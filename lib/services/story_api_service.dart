import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/story.dart';
import '../constants/app_constants.dart';

class StoryApiService {
  static const String _baseUrl = AppConstants.apiBaseUrl;

  Future<List<Story>> fetchStories() async {
    final response = await http.get(Uri.parse('$_baseUrl/stories/'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load stories: ${response.statusCode}');
    }
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Story.fromJson(json)).toList();
  }

  Future<Story> fetchStory(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/stories/$id'));
    if (response.statusCode != 200) {
      throw Exception('Story not found: $id');
    }
    return Story.fromJson(jsonDecode(response.body));
  }
}
