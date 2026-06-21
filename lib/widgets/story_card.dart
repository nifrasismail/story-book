import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/story.dart';
import '../constants/app_colors.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  final bool isCompleted;
  final bool isFavourite;
  final bool isLocked;
  final VoidCallback onTap;
  final VoidCallback? onFavouriteTap;

  const StoryCard({
    super.key,
    required this.story,
    required this.isCompleted,
    required this.isFavourite,
    required this.isLocked,
    required this.onTap,
    this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: story.themeColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Cover image or gradient background
              if (story.coverImageUrl != null)
                Positioned.fill(
                  child: Image.network(
                    story.coverImageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _gradientBackground(),
                  ),
                )
              else
                Positioned.fill(child: _gradientBackground()),

              // Dark gradient overlay so text is readable
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.65),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: lock/complete + favourite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatusBadge(isCompleted: isCompleted, isLocked: isLocked),
                        GestureDetector(
                          onTap: onFavouriteTap,
                          child: Icon(
                            isFavourite ? Icons.favorite : Icons.favorite_border,
                            color: isFavourite ? Colors.red : Colors.white70,
                            size: 22,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Title
                    Text(
                      story.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        height: 1.2,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Meta row
                    Row(
                      children: [
                        _MetaChip('⏱ ${story.readingTimeMinutes}m'),
                        const SizedBox(width: 4),
                        _MetaChip('⭐ ${story.starsReward}'),
                      ],
                    ),
                  ],
                ),
              ),

              // Locked overlay
              if (isLocked)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_rounded, color: Colors.white, size: 36),
                        SizedBox(height: 4),
                        Text(
                          'Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }

  Widget _gradientBackground() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [story.themeColor, story.themeColor.withValues(alpha: 0.7)],
          ),
        ),
      );
}

class _StatusBadge extends StatelessWidget {
  final bool isCompleted;
  final bool isLocked;

  const _StatusBadge({required this.isCompleted, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.premium,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          '💎 PRO',
          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
        ),
      );
    }
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          '✓ Done',
          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '📖 Free',
        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String text;
  const _MetaChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }
}
