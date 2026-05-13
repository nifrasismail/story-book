class BadgeModel {
  final String id;
  final String name;
  final String description;
  final String emoji;
  final bool isUnlocked;

  const BadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.emoji,
    this.isUnlocked = false,
  });

  BadgeModel copyWith({bool? isUnlocked}) => BadgeModel(
        id: id,
        name: name,
        description: description,
        emoji: emoji,
        isUnlocked: isUnlocked ?? this.isUnlocked,
      );

  static const List<BadgeModel> defaults = [
    BadgeModel(
      id: 'first_story',
      name: 'First Story',
      description: 'Read your very first story!',
      emoji: '📖',
    ),
    BadgeModel(
      id: 'bookworm',
      name: 'Bookworm',
      description: 'Read 5 stories',
      emoji: '🐛',
    ),
    BadgeModel(
      id: 'story_star',
      name: 'Story Star',
      description: 'Read 10 stories',
      emoji: '⭐',
    ),
    BadgeModel(
      id: 'master_reader',
      name: 'Master Reader',
      description: 'Read all 20 stories',
      emoji: '🏆',
    ),
    BadgeModel(
      id: 'early_bird',
      name: 'Early Bird',
      description: 'Read a story before 9 AM',
      emoji: '🐦',
    ),
    BadgeModel(
      id: 'night_owl',
      name: 'Night Owl',
      description: 'Read a story after 8 PM',
      emoji: '🦉',
    ),
    BadgeModel(
      id: 'streak_starter',
      name: 'Streak Starter',
      description: '3-day reading streak',
      emoji: '🔥',
    ),
    BadgeModel(
      id: 'streak_master',
      name: 'Streak Master',
      description: '7-day reading streak',
      emoji: '🌟',
    ),
    BadgeModel(
      id: 'fable_fan',
      name: 'Fable Fan',
      description: 'Read all fables',
      emoji: '🐢',
    ),
    BadgeModel(
      id: 'fairy_tale_fan',
      name: 'Fairy Tale Fan',
      description: 'Read all fairy tales',
      emoji: '🧚',
    ),
    BadgeModel(
      id: 'premium_reader',
      name: 'Premium Reader',
      description: 'Read your first premium story',
      emoji: '💎',
    ),
    BadgeModel(
      id: 'star_collector',
      name: 'Star Collector',
      description: 'Collect 50 stars',
      emoji: '✨',
    ),
  ];
}
