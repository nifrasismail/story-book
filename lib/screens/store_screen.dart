import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../providers/purchase_provider.dart';
import '../services/ad_service.dart';

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
    final purchase = context.watch<PurchaseProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('✨ Story Store',
                        style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Unlock magical premium stories and remove ads!',
                      style: TextStyle(
                          color: AppColors.textMedium, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

            // Status banner if has premium
            if (purchase.hasPremiumPack)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8338EC), Color(0xFFB86EFF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Text('💎', style: TextStyle(fontSize: 32)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Premium Member! 🎉',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                              Text(
                                'All premium stories are unlocked!',
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Products
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ── Bundle (best value) ──────────────────────────────────
                  _ProductCard(
                    emoji: '🌟',
                    title: 'Magic Bundle',
                    subtitle: 'All 10 premium stories + Remove Ads',
                    price: '\$6.99',
                    highlight: 'Best Value! Save 30%',
                    highlightColor: AppColors.primary,
                    gradientColors: const [Color(0xFFFF6B35), Color(0xFFF9C74F)],
                    isOwned: purchase.hasPremiumPack && purchase.hasRemovedAds,
                    isLoading: purchase.isLoading,
                    onBuy: () => purchase.purchaseBundle(),
                  ),

                  const SizedBox(height: 14),

                  // ── Premium stories ──────────────────────────────────────
                  _ProductCard(
                    emoji: '💎',
                    title: 'Premium Stories Pack',
                    subtitle: 'Unlock all 10 magical premium stories',
                    price: '\$4.99',
                    highlight: '10 Enchanting Stories',
                    highlightColor: AppColors.purple,
                    gradientColors: const [Color(0xFF8338EC), Color(0xFFB86EFF)],
                    isOwned: purchase.hasPremiumPack,
                    isLoading: purchase.isLoading,
                    onBuy: () => purchase.purchasePremiumPack(),
                  ),

                  const SizedBox(height: 14),

                  // ── Remove ads ───────────────────────────────────────────
                  _ProductCard(
                    emoji: '🚫',
                    title: 'Remove Ads',
                    subtitle: 'Enjoy uninterrupted story time!',
                    price: '\$2.99',
                    highlight: 'Ad-Free Experience',
                    highlightColor: AppColors.secondary,
                    gradientColors: const [Color(0xFF4ECDC4), Color(0xFF45B7D1)],
                    isOwned: purchase.hasRemovedAds,
                    isLoading: purchase.isLoading,
                    onBuy: () => purchase.purchaseRemoveAds(),
                  ),

                  const SizedBox(height: 20),

                  // ── Free reward ad ───────────────────────────────────────
                  _FreeUnlockCard(
                    isReady: _rewardAdReady,
                    onWatch: () {
                      AdService().showRewardedAd(
                        onRewarded: (reward) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  '🎉 You unlocked one premium story for free!'),
                              backgroundColor: AppColors.secondary,
                            ),
                          );
                        },
                        onDismissed: () {
                          setState(() {
                            _rewardAdReady = AdService().isRewardedAdReady;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // ── Restore ──────────────────────────────────────────────
                  Center(
                    child: TextButton(
                      onPressed: purchase.restorePurchases,
                      child: const Text(
                        'Restore Purchases',
                        style: TextStyle(
                            color: AppColors.textMedium, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Payments securely processed by Apple / Google.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String price;
  final String highlight;
  final Color highlightColor;
  final List<Color> gradientColors;
  final bool isOwned;
  final bool isLoading;
  final VoidCallback onBuy;

  const _ProductCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.highlight,
    required this.highlightColor,
    required this.gradientColors,
    required this.isOwned,
    required this.isLoading,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: highlightColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gradient header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          highlight,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 24),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                isOwned
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Text(
                          '✓ Owned',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: isLoading ? null : onBuy,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gradientColors.first,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Text('Buy Now'),
                      ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 300.ms);
  }
}

class _FreeUnlockCard extends StatelessWidget {
  final bool isReady;
  final VoidCallback onWatch;

  const _FreeUnlockCard({required this.isReady, required this.onWatch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.green.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Text('🎬', style: TextStyle(fontSize: 36)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Try for Free!',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
                const Text(
                  'Watch a short video to unlock one premium story',
                  style: TextStyle(
                      color: AppColors.textMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: isReady ? onWatch : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const Text('Watch'),
          ),
        ],
      ),
    );
  }
}
