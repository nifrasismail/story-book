import 'package:flutter/foundation.dart';
import '../models/badge_model.dart';
import '../models/user_progress.dart';
import '../services/storage_service.dart';
import '../constants/app_constants.dart';

class RewardsProvider extends ChangeNotifier {
  final StorageService _storage;

  RewardsProvider(this._storage) {
    _load();
    _processLogin();
  }

  late UserProgress _progress;
  List<BadgeModel> _badges = BadgeModel.defaults.toList();
  int _newStarsEarned = 0;
  bool _leveledUp = false;

  UserProgress get progress => _progress;
  List<BadgeModel> get badges => _badges;
  int get newStarsEarned => _newStarsEarned;
  bool get leveledUp => _leveledUp;

  void _load() {
    _progress = UserProgress(
      totalStars: _storage.totalStars,
      currentStreak: _storage.currentStreak,
      longestStreak: _storage.longestStreak,
      completedStoryIds: _storage.completedStoryIds,
      unlockedBadgeIds: _storage.unlockedBadgeIds,
      lastReadDate: _storage.lastReadDate,
      lastLoginDate: _storage.lastLoginDate,
    );
    _applyUnlocks();
  }

  void _applyUnlocks() {
    _badges = BadgeModel.defaults
        .map((b) =>
            b.copyWith(isUnlocked: _progress.unlockedBadgeIds.contains(b.id)))
        .toList();
  }

  // ── Daily login ────────────────────────────────────────────────────────────
  void _processLogin() {
    final now = DateTime.now();
    final last = _progress.lastLoginDate;
    if (last == null || !_isSameDay(last, now)) {
      _awardStars(AppConstants.dailyLoginStars, notify: false);
      _updateStreak(now);
      _storage.setLastLoginDate(now);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _updateStreak(DateTime now) {
    final last = _progress.lastLoginDate;
    int streak = _progress.currentStreak;
    if (last == null) {
      streak = 1;
    } else {
      final diff = now.difference(last).inDays;
      if (diff == 1) {
        streak++;
        _awardStars(AppConstants.streakBonusStars, notify: false);
      } else if (diff > 1) {
        streak = 1;
      }
    }
    final longest = streak > _progress.longestStreak ? streak : _progress.longestStreak;
    _progress = _progress.copyWith(currentStreak: streak, longestStreak: longest);
    _storage.setCurrentStreak(streak);
    _storage.setLongestStreak(longest);
  }

  // ── Award stars ────────────────────────────────────────────────────────────
  void _awardStars(int count, {bool notify = true}) {
    final prevLevel = _progress.level;
    _progress = _progress.copyWith(totalStars: _progress.totalStars + count);
    _newStarsEarned = count;
    _storage.setTotalStars(_progress.totalStars);
    if (_progress.level > prevLevel) _leveledUp = true;
    if (notify) notifyListeners();
  }

  Future<void> onStoryCompleted({
    required String storyId,
    required int starsReward,
    required bool isPremium,
    required int hour,
  }) async {
    final updated = {..._progress.completedStoryIds, storyId};
    _progress = _progress.copyWith(
      completedStoryIds: updated,
      lastReadDate: DateTime.now(),
    );
    _storage.setCompletedStoryIds(updated);
    _storage.setLastReadDate(DateTime.now());

    _awardStars(starsReward);
    _checkBadges(hour: hour, isPremium: isPremium);
    notifyListeners();
  }

  // ── Badge check ────────────────────────────────────────────────────────────
  void _checkBadges({required int hour, required bool isPremium}) {
    final completed = _progress.completedStoryIds;
    final unlocked = Set<String>.from(_progress.unlockedBadgeIds);

    void tryUnlock(String id) => unlocked.add(id);

    if (completed.length >= 1) tryUnlock('first_story');
    if (completed.length >= 5) tryUnlock('bookworm');
    if (completed.length >= 10) tryUnlock('story_star');
    if (completed.length >= 20) tryUnlock('master_reader');
    if (hour < 9) tryUnlock('early_bird');
    if (hour >= 20) tryUnlock('night_owl');
    if (_progress.currentStreak >= 3) tryUnlock('streak_starter');
    if (_progress.currentStreak >= 7) tryUnlock('streak_master');
    if (isPremium) tryUnlock('premium_reader');
    if (_progress.totalStars >= 50) tryUnlock('star_collector');

    _progress = _progress.copyWith(unlockedBadgeIds: unlocked);
    _storage.setUnlockedBadgeIds(unlocked);
    _applyUnlocks();
  }

  void clearAnimationFlags() {
    _newStarsEarned = 0;
    _leveledUp = false;
  }
}
