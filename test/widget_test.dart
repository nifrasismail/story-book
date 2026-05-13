import 'package:flutter_test/flutter_test.dart';
import 'package:kidstories/data/stories_data.dart';

void main() {
  test('All stories have required fields', () {
    for (final story in kAllStories) {
      expect(story.id.isNotEmpty, true, reason: 'Story ${story.title} has no id');
      expect(story.title.isNotEmpty, true);
      expect(story.pages.isNotEmpty, true);
      expect(story.starsReward > 0, true);
    }
  });

  test('10 free and 10 premium stories', () {
    final free = kAllStories.where((s) => !s.isPremium).length;
    final premium = kAllStories.where((s) => s.isPremium).length;
    expect(free, 10);
    expect(premium, 10);
  });
}
