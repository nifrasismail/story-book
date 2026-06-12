import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constants/app_colors.dart';
import '../models/story.dart';
import '../providers/rewards_provider.dart';
import '../providers/story_provider.dart';
import '../services/ad_service.dart';
import '../services/notification_service.dart';
import '../providers/purchase_provider.dart';

class StoryReaderScreen extends StatefulWidget {
  final Story story;
  const StoryReaderScreen({super.key, required this.story});

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  final PageController _pageCtrl = PageController();
  late ConfettiController _confettiCtrl;
  int _currentPage = 0;
  bool _completed = false;
  Story? _loadedStory;
  bool _pagesLoading = true;

  Story get _story => _loadedStory ?? widget.story;

  @override
  void initState() {
    super.initState();
    _confettiCtrl = ConfettiController(duration: const Duration(seconds: 3));
    AdService().loadInterstitial();
    _fetchPages();
  }

  Future<void> _fetchPages() async {
    final provider = context.read<StoryProvider>();
    final full = await provider.fetchStoryWithPages(widget.story.id);
    if (mounted) {
      setState(() {
        _loadedStory = full;
        _pagesLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _confettiCtrl.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    if (page == _story.pages.length - 1 && !_completed) {
      _completeStory();
    }
  }

  Future<void> _completeStory() async {
    setState(() => _completed = true);
    _confettiCtrl.play();

    final rewards = context.read<RewardsProvider>();
    final storyProv = context.read<StoryProvider>();
    final hour = DateTime.now().hour;

    await rewards.onStoryCompleted(
      storyId: widget.story.id,
      starsReward: widget.story.starsReward,
      isPremium: widget.story.isPremium,
      hour: hour,
    );
    await storyProv.markCompleted(widget.story.id);

    NotificationService().showStoryCompletedNotification(widget.story.title);

    // Show interstitial after free stories
    final purchase = context.read<PurchaseProvider>();
    if (!purchase.hasRemovedAds && !widget.story.isPremium) {
      AdService().showInterstitial();
    }
  }

  void _nextPage() {
    if (_currentPage < _story.pages.length - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageCtrl.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pagesLoading) {
      return Scaffold(
        backgroundColor: _story.themeColor.withOpacity(0.1),
        body: Center(
          child: CircularProgressIndicator(color: _story.themeColor),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          // Page view
          PageView.builder(
            controller: _pageCtrl,
            onPageChanged: _onPageChanged,
            itemCount: _story.pages.length,
            itemBuilder: (_, i) => _StoryPage(
              page: _story.pages[i],
              story: _story,
              pageIndex: i,
              totalPages: _story.pages.length,
            ),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _CircleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  // Page indicator
                  SmoothPageIndicator(
                    controller: _pageCtrl,
                    count: _story.pages.length,
                    effect: WormEffect(
                      dotColor: Colors.white54,
                      activeDotColor: widget.story.themeColor,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  const Spacer(),
                  Consumer<StoryProvider>(
                    builder: (_, sp, __) => _CircleButton(
                      icon: sp.isFavourite(widget.story.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      iconColor: sp.isFavourite(widget.story.id)
                          ? Colors.red
                          : Colors.white,
                      onTap: () => sp.toggleFavourite(widget.story.id),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigation arrows (sides)
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: _currentPage > 0
                  ? _CircleButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: _prevPage,
                    )
                  : const SizedBox(width: 40),
            ),
          ),
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: _currentPage < _story.pages.length - 1
                  ? _CircleButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: _nextPage,
                    )
                  : const SizedBox(width: 40),
            ),
          ),

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiCtrl,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 40,
              colors: const [
                AppColors.primary,
                AppColors.secondary,
                AppColors.accent,
                AppColors.purple,
                AppColors.pink,
                AppColors.green,
              ],
            ),
          ),

          // Completion banner
          if (_completed && _currentPage == _story.pages.length - 1)
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: _CompletionBanner(story: widget.story),
            ),
        ],
      ),
    );
  }
}

class _StoryPage extends StatelessWidget {
  final StoryPage page;
  final Story story;
  final int pageIndex;
  final int totalPages;

  const _StoryPage({
    required this.page,
    required this.story,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: page.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 70, 24, 24),
          child: Column(
            children: [
              // Story title + page counter
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    story.title,
                    style: TextStyle(
                      color: story.themeColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: story.themeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${pageIndex + 1} / $totalPages',
                      style: TextStyle(
                        color: story.themeColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Page illustration — API image if available, emoji fallback
              (page.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        page.imageUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Text(
                          page.emoji,
                          style: const TextStyle(fontSize: 80),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Text(
                      page.emoji,
                      style: const TextStyle(fontSize: 80),
                      textAlign: TextAlign.center,
                    ))
                  .animate(key: ValueKey(pageIndex))
                  .scale(
                    begin: const Offset(0.7, 0.7),
                    duration: 400.ms,
                    curve: Curves.elasticOut,
                  )
                  .fade(duration: 300.ms),

              const SizedBox(height: 28),

              // Story text
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    page.text,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate(key: ValueKey('txt_$pageIndex'))
                      .fade(delay: 150.ms, duration: 400.ms)
                      .slideY(begin: 0.1, end: 0, delay: 150.ms, duration: 400.ms),
                ),
              ),

              const SizedBox(height: 16),
              // Swipe hint
              if (pageIndex < totalPages - 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.swipe_right_alt, color: story.themeColor, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      'Swipe for next page',
                      style: TextStyle(
                        color: story.themeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletionBanner extends StatelessWidget {
  final Story story;
  const _CompletionBanner({required this.story});

  @override
  Widget build(BuildContext context) {
    final rewards = context.watch<RewardsProvider>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🎉', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 8),
          Text(
            'Story Complete!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'You earned ${story.starsReward} ⭐ stars!',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF92600A),
            ),
          ),
          const SizedBox(height: 12),
          if (rewards.leveledUp)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '⬆️ Level Up! You\'re now a ${rewards.progress.levelInfo.title} ${rewards.progress.levelInfo.emoji}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
              ),
            ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: story.themeColor,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Back to Stories 📚'),
          ),
        ],
      ),
    )
        .animate()
        .slideY(begin: 0.5, end: 0, duration: 500.ms, curve: Curves.elasticOut)
        .fade(duration: 300.ms);
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black38,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? Colors.white, size: 22),
      ),
    );
  }
}
