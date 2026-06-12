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
  final String? imageUrl;

  const StoryPage({
    required this.emoji,
    required this.text,
    required this.backgroundColor,
    this.imageUrl,
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
  final String? coverImageUrl;

  factory Story.fromJson(Map<String, dynamic> json) {
    final categoryMap = {
      'classic': StoryCategory.classic,
      'fable': StoryCategory.fable,
      'fairyTale': StoryCategory.fairyTale,
      'adventure': StoryCategory.adventure,
    };

    Color parseHex(String hex) {
      final cleaned = hex.replaceAll('#', '');
      return Color(int.parse('FF$cleaned', radix: 16));
    }

    return Story(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: categoryMap[json['category']] ?? StoryCategory.classic,
      ageRange: json['age_range'] as String,
      readingTimeMinutes: json['reading_time_minutes'] as int,
      isPremium: json['is_premium'] as bool,
      starsReward: json['stars_reward'] as int,
      themeColor: json['theme_color'] != null
          ? parseHex(json['theme_color'] as String)
          : const Color(0xFF6C63FF),
      coverEmoji: json['cover_emoji'] as String,
      moral: json['moral'] as String,
      coverImageUrl: json['cover_image_url'] as String?,
      pages: (json['pages'] as List<dynamic>? ?? [])
          .map((p) => StoryPage(
                emoji: p['emoji'] as String,
                text: p['text'] as String,
                backgroundColor: parseHex(p['background_color'] as String),
                imageUrl: p['image_url'] as String?,
              ))
          .toList(),
    );
  }

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
    this.coverImageUrl,
  });
}
