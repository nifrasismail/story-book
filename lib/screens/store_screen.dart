import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/purchase_provider.dart';
import '../providers/rewards_provider.dart';
import '../services/ad_service.dart';
import '../services/remote_config_service.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool _rewardAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadRewardAd();
  }

  Future<void> _loadRewardAd() async {
    await AdService().loadRewardedAd();
    if (mounted) setState(() => _rewardAdReady = AdService().isRewardedAdReady);
  }

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
                    Text('🎬 Free Stories',
                        style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Watch a short video to unlock any premium story for free!',
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

                  const SizedBox(height: 20),

                  // ── Watch ad to unlock ─────────────────────────────────
                  if (RemoteConfigService().adsEnabled) ...[
                    _WatchToUnlockCard(
                      isReady: _rewardAdReady,
                      onWatch: () => _showRewardedAd(context),
                      onNotReady: _loadRewardAd,
                    ),

                    const SizedBox(height: 20),

                    // ── How it works ─────────────────────────────────────
                    _HowItWorksCard(),

                    const SizedBox(height: 20),
                  ],

                  // ── Coming soon banner ─────────────────────────────────
                  _ComingSoonCard(),

                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRewardedAd(BuildContext context) {
    AdService().showRewardedAd(
      onRewarded: (_) {
        context.read<PurchaseProvider>().grantTemporaryPremium();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 Premium stories unlocked for this session!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      },
      onDismissed: () {
        if (mounted) setState(() => _rewardAdReady = AdService().isRewardedAdReady);
        _loadRewardAd();
      },
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

class _WatchToUnlockCard extends StatelessWidget {
  final bool isReady;
  final VoidCallback onWatch;
  final VoidCallback onNotReady;

  const _WatchToUnlockCard({
    required this.isReady,
    required this.onWatch,
    required this.onNotReady,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('🎬', style: TextStyle(fontSize: 52)),
          const SizedBox(height: 12),
          const Text(
            'Watch a Short Video',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            'Unlock all premium stories for your reading session — completely free!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.textMedium,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_circle_fill_rounded,
                  color: Colors.white, size: 22),
              label: Text(
                isReady ? 'Watch Now — It\'s Free!' : 'Loading Ad...',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: isReady ? onWatch : onNotReady,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.1, end: 0);
  }
}

class _HowItWorksCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('How it works',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 12),
          _Step(number: '1', text: 'Tap a premium story (marked 💎)'),
          _Step(number: '2', text: 'Choose "Watch Ad to Unlock"'),
          _Step(number: '3', text: 'Watch a 15–30 sec video'),
          _Step(number: '4', text: 'Enjoy the full story — no charge!'),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }
}

class _Step extends StatelessWidget {
  final String number;
  final String text;
  const _Step({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.primary,
            child: Text(number,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Text(text,
              style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ComingSoonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Text('💎', style: TextStyle(fontSize: 36)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Premium Subscription — Coming Soon',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.purple),
                ),
                const SizedBox(height: 4),
                Text(
                  'Unlimited access to all stories, no ads, offline reading — launching soon!',
                  style: TextStyle(
                      color: AppColors.textMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms);
  }
}
