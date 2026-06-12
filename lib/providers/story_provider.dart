import 'package:flutter/foundation.dart';
import '../models/story.dart';
import '../services/story_api_service.dart';
import '../services/storage_service.dart';

class StoryProvider extends ChangeNotifier {
  final StorageService _storage;
  final StoryApiService _api = StoryApiService();

  StoryProvider(this._storage) {
    _load();
  }

  List<Story> _stories = [];
  bool _isLoading = false;
  String? _error;
  Set<String> _completedIds = {};
  Set<String> _favouriteIds = {};
  StoryCategory _selectedCategory = StoryCategory.all;
  String _searchQuery = '';

  List<Story> get allStories => _stories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Set<String> get completedIds => _completedIds;
  Set<String> get favouriteIds => _favouriteIds;
  StoryCategory get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<Story> get filteredStories {
    var list = _stories;
    if (_selectedCategory != StoryCategory.all) {
      list = list.where((s) => s.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((s) => s.title.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  List<Story> get freeStories => _stories.where((s) => !s.isPremium).toList();
  List<Story> get premiumStories => _stories.where((s) => s.isPremium).toList();
  List<Story> get favouriteStories =>
      _stories.where((s) => _favouriteIds.contains(s.id)).toList();

  bool isCompleted(String id) => _completedIds.contains(id);
  bool isFavourite(String id) => _favouriteIds.contains(id);
  int get totalCompleted => _completedIds.length;

  Future<void> _load() async {
    _completedIds = _storage.completedStoryIds;
    _favouriteIds = _storage.favouriteStoryIds;
    await fetchStories();
  }

  Future<void> fetchStories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _stories = await _api.fetchStories();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Story?> fetchStoryWithPages(String id) async {
    try {
      return await _api.fetchStory(id);
    } catch (e) {
      return null;
    }
  }

  Future<void> markCompleted(String id) async {
    _completedIds = {..._completedIds, id};
    await _storage.setCompletedStoryIds(_completedIds);
    notifyListeners();
  }

  Future<void> toggleFavourite(String id) async {
    if (_favouriteIds.contains(id)) {
      _favouriteIds = _favouriteIds.where((s) => s != id).toSet();
    } else {
      _favouriteIds = {..._favouriteIds, id};
    }
    await _storage.setFavouriteStoryIds(_favouriteIds);
    notifyListeners();
  }

  void setCategory(StoryCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }
}
