import 'package:flutter/foundation.dart';
import '../data/stories_data.dart';
import '../models/story.dart';
import '../services/storage_service.dart';

class StoryProvider extends ChangeNotifier {
  final StorageService _storage;

  StoryProvider(this._storage) {
    _load();
  }

  Set<String> _completedIds = {};
  Set<String> _favouriteIds = {};
  StoryCategory _selectedCategory = StoryCategory.all;
  String _searchQuery = '';

  Set<String> get completedIds => _completedIds;
  Set<String> get favouriteIds => _favouriteIds;
  StoryCategory get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<Story> get allStories => kAllStories;

  List<Story> get filteredStories {
    var list = kAllStories;
    if (_selectedCategory != StoryCategory.all) {
      list = list.where((s) => s.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((s) => s.title.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  List<Story> get freeStories => kAllStories.where((s) => !s.isPremium).toList();
  List<Story> get premiumStories => kAllStories.where((s) => s.isPremium).toList();
  List<Story> get favouriteStories =>
      kAllStories.where((s) => _favouriteIds.contains(s.id)).toList();

  bool isCompleted(String id) => _completedIds.contains(id);
  bool isFavourite(String id) => _favouriteIds.contains(id);

  int get totalCompleted => _completedIds.length;

  void _load() {
    _completedIds = _storage.completedStoryIds;
    _favouriteIds = _storage.favouriteStoryIds;
    notifyListeners();
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
