class LevelInfo {
  final int level;
  final String title;
  final String emoji;

  const LevelInfo(this.level, this.title, this.emoji);
}

const List<LevelInfo> kLevels = [
  LevelInfo(1, 'Tiny Tadpole', '🐸'),
  LevelInfo(2, 'Eager Eaglet', '🦅'),
  LevelInfo(3, 'Clever Cub', '🐻'),
  LevelInfo(4, 'Brave Dragon', '🐉'),
  LevelInfo(5, 'Wise Wizard', '🧙'),
  LevelInfo(6, 'Story Master', '📚'),
  LevelInfo(7, 'Grand Champion', '🏆'),
  LevelInfo(8, 'Legendary Reader', '👑'),
  LevelInfo(9, 'Storybook Hero', '🦸'),
  LevelInfo(10, 'Ultimate Storyteller', '🌟'),
];

class UserProgress {
  final int totalStars;
  final int currentStreak;
  final int longestStreak;
  final Set<String> completedStoryIds;
  final Set<String> favoriteStoryIds;
  final Set<String> unlockedBadgeIds;
  final DateTime? lastReadDate;
  final DateTime? lastLoginDate;

  const UserProgress({
    this.totalStars = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.completedStoryIds = const {},
    this.favoriteStoryIds = const {},
    this.unlockedBadgeIds = const {},
    this.lastReadDate,
    this.lastLoginDate,
  });

  int get level {
    final l = (totalStars ~/ 15).clamp(0, 9);
    return l + 1;
  }

  int get starsToNextLevel {
    final nextThreshold = level * 15;
    return nextThreshold - totalStars;
  }

  double get levelProgress {
    final base = (level - 1) * 15;
    final next = level * 15;
    return ((totalStars - base) / (next - base)).clamp(0.0, 1.0);
  }

  LevelInfo get levelInfo => kLevels[(level - 1).clamp(0, 9)];

  UserProgress copyWith({
    int? totalStars,
    int? currentStreak,
    int? longestStreak,
    Set<String>? completedStoryIds,
    Set<String>? favoriteStoryIds,
    Set<String>? unlockedBadgeIds,
    DateTime? lastReadDate,
    DateTime? lastLoginDate,
  }) {
    return UserProgress(
      totalStars: totalStars ?? this.totalStars,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      completedStoryIds: completedStoryIds ?? this.completedStoryIds,
      favoriteStoryIds: favoriteStoryIds ?? this.favoriteStoryIds,
      unlockedBadgeIds: unlockedBadgeIds ?? this.unlockedBadgeIds,
      lastReadDate: lastReadDate ?? this.lastReadDate,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
    );
  }
}
