import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

class UserApiService {
  final String _base = AppConstants.apiBaseUrl;

  Future<Map<String, dynamic>> getProfile(String accessToken) async {
    final resp = await http.get(
      Uri.parse('$_base/user/profile'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return _handle(resp);
  }

  Future<void> syncProgress({
    required String accessToken,
    required int totalStars,
    required int currentStreak,
    required int longestStreak,
    required String? lastReadDate,
    required List<String> completedStoryIds,
    required List<String> favouriteStoryIds,
    required List<String> unlockedBadgeIds,
  }) async {
    final resp = await http.post(
      Uri.parse('$_base/user/sync'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'total_stars': totalStars,
        'current_streak': currentStreak,
        'longest_streak': longestStreak,
        'last_read_date': lastReadDate,
        'completed_story_ids': completedStoryIds,
        'favourite_story_ids': favouriteStoryIds,
        'unlocked_badge_ids': unlockedBadgeIds,
      }),
    );
    _handle(resp);
  }

  Map<String, dynamic> _handle(http.Response resp) {
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode >= 400) {
      throw Exception(body['detail'] ?? 'Request failed');
    }
    return body;
  }
}
