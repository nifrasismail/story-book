import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/rewards_provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = context.watch<RewardsProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('📚 Your Progress',
                        style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 4),
                    Text(
                      'All stories are free to read!',
                      style: TextStyle(
                          color: AppColors.textMedium,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([

                  // ── Stats card ─────────────────────────────────────────
                  _StatsCard(
                    totalStars: rewards.progress.totalStars,
                    completed: rewards.progress.completedStoryIds.length,
                    streak: rewards.progress.currentStreak,
                  ),

                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widgets ──────────────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  final int totalStars;
  final int completed;
  final int streak;

  const _StatsCard({
    required this.totalStars,
    required this.completed,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFF9C74F)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Stat(icon: '⭐', value: '$totalStars', label: 'Stars'),
          _Stat(icon: '📖', value: '$completed', label: 'Read'),
          _Stat(icon: '🔥', value: '$streak', label: 'Streak'),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }
}

class _Stat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _Stat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 22)),
        Text(label,
            style: const TextStyle(
                color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
