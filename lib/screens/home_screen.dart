import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../models/story.dart';
import '../providers/purchase_provider.dart';
import '../providers/rewards_provider.dart';
import '../providers/story_provider.dart';
import '../widgets/ad_banner_widget.dart';
import '../widgets/star_counter_widget.dart';
import '../widgets/story_card.dart';
import 'rewards_screen.dart';
import 'store_screen.dart';
import 'story_reader_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  final List<Widget> _pages = const [
    _StoryLibrary(),
    RewardsScreen(),
    StoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _navIndex, children: _pages),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Banner ad for free users
          Consumer<PurchaseProvider>(
            builder: (_, p, __) =>
                p.hasRemovedAds ? const SizedBox.shrink() : const AdBannerWidget(),
          ),
          NavigationBar(
            selectedIndex: _navIndex,
            onDestinationSelected: (i) => setState(() => _navIndex = i),
            backgroundColor: Colors.white,
            elevation: 10,
            indicatorColor: AppColors.primary.withOpacity(0.15),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.auto_stories_outlined),
                selectedIcon: Icon(Icons.auto_stories),
                label: 'Stories',
              ),
              NavigationDestination(
                icon: Icon(Icons.emoji_events_outlined),
                selectedIcon: Icon(Icons.emoji_events),
                label: 'Rewards',
              ),
              NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront),
                label: 'Store',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
class _StoryLibrary extends StatelessWidget {
  const _StoryLibrary();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _Header(),
          _SearchBar(),
          _CategoryFilter(),
          Expanded(child: _StoryGrid()),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rewards = context.watch<RewardsProvider>();
    final info = rewards.progress.levelInfo;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KidStories 📚',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '${info.emoji} ${info.title}',
                style: TextStyle(
                  color: AppColors.textMedium,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          StarCounterWidget(count: rewards.progress.totalStars),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextField(
        controller: _ctrl,
        onChanged: (v) => context.read<StoryProvider>().setSearchQuery(v),
        decoration: InputDecoration(
          hintText: 'Search stories...',
          hintStyle: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.w600),
          prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
          suffixIcon: _ctrl.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _ctrl.clear();
                    context.read<StoryProvider>().setSearchQuery('');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = context.watch<StoryProvider>().selectedCategory;
    return SizedBox(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: StoryCategory.values.map((cat) {
          final isSelected = cat == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => context.read<StoryProvider>().setCategory(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.3)
                          : Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '${cat.emoji} ${cat.label}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storyProv = context.watch<StoryProvider>();
    final purchaseProv = context.watch<PurchaseProvider>();
    final stories = storyProv.filteredStories;

    if (storyProv.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (storyProv.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('😕', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 12),
            Text('Could not load stories', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => storyProv.fetchStories(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (stories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📭', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 12),
            Text(
              'No stories found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: stories.length,
      itemBuilder: (ctx, i) {
        final story = stories[i];
        final isLocked = story.isPremium && !purchaseProv.hasPremiumPack;
        return StoryCard(
          story: story,
          isCompleted: storyProv.isCompleted(story.id),
          isFavourite: storyProv.isFavourite(story.id),
          isLocked: isLocked,
          onFavouriteTap: () => storyProv.toggleFavourite(story.id),
          onTap: () {
            if (isLocked) {
              _showLockedDialog(ctx);
            } else {
              Navigator.push(
                ctx,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => StoryReaderScreen(story: story),
                  transitionsBuilder: (_, anim, __, child) =>
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(parent: anim, curve: Curves.easeOut),
                        ),
                        child: child,
                      ),
                  transitionDuration: const Duration(milliseconds: 400),
                ),
              );
            }
          },
        );
      },
    );
  }

  void _showLockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('💎 Premium Story', textAlign: TextAlign.center),
        content: const Text(
          'This is a premium story. Unlock all premium stories to enjoy endless magical adventures!',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to store via bottom nav — simple approach
            },
            child: const Text('Unlock Now ✨'),
          ),
        ],
      ),
    );
  }
}
