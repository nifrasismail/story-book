import 'package:flutter/material.dart';

enum StoryCategory { all, classic, fable, fairyTale, adventure }

extension StoryCategoryLabel on StoryCategory {
  String get label {
    switch (this) {
      case StoryCategory.all:
        return 'All';
      case StoryCategory.classic:
        return 'Classic';
      case StoryCategory.fable:
        return 'Fable';
      case StoryCategory.fairyTale:
        return 'Fairy Tale';
      case StoryCategory.adventure:
        return 'Adventure';
    }
  }

  String get emoji {
    switch (this) {
      case StoryCategory.all:
        return '📚';
      case StoryCategory.classic:
        return '🏰';
      case StoryCategory.fable:
        return '🦁';
      case StoryCategory.fairyTale:
        return '🧚';
      case StoryCategory.adventure:
        return '🗺️';
    }
  }
}

class StoryPage {
  final String emoji;
  final String text;
  final Color backgroundColor;

  const StoryPage({
    required this.emoji,
    required this.text,
    required this.backgroundColor,
  });
}

class Story {
  final String id;
  final String title;
  final String description;
  final StoryCategory category;
  final String ageRange;
  final int readingTimeMinutes;
  final List<StoryPage> pages;
  final bool isPremium;
  final int starsReward;
  final Color themeColor;
  final String coverEmoji;
  final String moral;

  const Story({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.ageRange,
    required this.readingTimeMinutes,
    required this.pages,
    required this.isPremium,
    required this.starsReward,
    required this.themeColor,
    required this.coverEmoji,
    required this.moral,
  });
}
