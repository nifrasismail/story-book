import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── Stars & Level ──────────────────────────────────────────────────────────
  int get totalStars => _prefs.getInt('total_stars') ?? 0;
  Future<void> setTotalStars(int v) => _prefs.setInt('total_stars', v);

  // ── Streak ─────────────────────────────────────────────────────────────────
  int get currentStreak => _prefs.getInt('current_streak') ?? 0;
  Future<void> setCurrentStreak(int v) => _prefs.setInt('current_streak', v);

  int get longestStreak => _prefs.getInt('longest_streak') ?? 0;
  Future<void> setLongestStreak(int v) => _prefs.setInt('longest_streak', v);

  // ── Dates ──────────────────────────────────────────────────────────────────
  DateTime? get lastReadDate {
    final s = _prefs.getString('last_read_date');
    return s != null ? DateTime.tryParse(s) : null;
  }

  Future<void> setLastReadDate(DateTime d) =>
      _prefs.setString('last_read_date', d.toIso8601String());

  DateTime? get lastLoginDate {
    final s = _prefs.getString('last_login_date');
    return s != null ? DateTime.tryParse(s) : null;
  }

  Future<void> setLastLoginDate(DateTime d) =>
      _prefs.setString('last_login_date', d.toIso8601String());

  // ── Completed stories ──────────────────────────────────────────────────────
  Set<String> get completedStoryIds {
    final list = _prefs.getStringList('completed_stories') ?? [];
    return list.toSet();
  }

  Future<void> setCompletedStoryIds(Set<String> ids) =>
      _prefs.setStringList('completed_stories', ids.toList());

  // ── Favourites ─────────────────────────────────────────────────────────────
  Set<String> get favouriteStoryIds {
    final list = _prefs.getStringList('favourite_stories') ?? [];
    return list.toSet();
  }

  Future<void> setFavouriteStoryIds(Set<String> ids) =>
      _prefs.setStringList('favourite_stories', ids.toList());

  // ── Badges ─────────────────────────────────────────────────────────────────
  Set<String> get unlockedBadgeIds {
    final list = _prefs.getStringList('unlocked_badges') ?? [];
    return list.toSet();
  }

  Future<void> setUnlockedBadgeIds(Set<String> ids) =>
      _prefs.setStringList('unlocked_badges', ids.toList());

  // ── IAP ────────────────────────────────────────────────────────────────────
  bool get hasPremiumPack => _prefs.getBool('has_premium_pack') ?? false;
  Future<void> setHasPremiumPack(bool v) => _prefs.setBool('has_premium_pack', v);

  bool get hasRemovedAds => _prefs.getBool('has_removed_ads') ?? false;
  Future<void> setHasRemovedAds(bool v) => _prefs.setBool('has_removed_ads', v);

  // ── Interstitial counter ──────────────────────────────────────────────────
  int get storiesReadSinceAd => _prefs.getInt('stories_read_since_ad') ?? 0;
  Future<void> setStoriesReadSinceAd(int v) =>
      _prefs.setInt('stories_read_since_ad', v);

  // ── Onboarding ─────────────────────────────────────────────────────────────
  bool get isFirstLaunch => _prefs.getBool('is_first_launch') ?? true;
  Future<void> setFirstLaunch(bool v) => _prefs.setBool('is_first_launch', v);

  // ── Auth session ───────────────────────────────────────────────────────────
  String? get accessToken => _prefs.getString('access_token');
  String? get refreshToken => _prefs.getString('refresh_token');
  String? get userId => _prefs.getString('user_id');
  String? get userEmail => _prefs.getString('user_email');
  String? get displayName => _prefs.getString('display_name');

  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String email,
    String? displayName,
  }) async {
    await _prefs.setString('access_token', accessToken);
    await _prefs.setString('refresh_token', refreshToken);
    await _prefs.setString('user_id', userId);
    await _prefs.setString('user_email', email);
    if (displayName != null) await _prefs.setString('display_name', displayName);
  }

  Future<void> clearSession() async {
    await _prefs.remove('access_token');
    await _prefs.remove('refresh_token');
    await _prefs.remove('user_id');
    await _prefs.remove('user_email');
    await _prefs.remove('display_name');
  }
}
