import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/purchase_provider.dart';
import 'providers/rewards_provider.dart';
import 'providers/story_provider.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

class KidStoriesApp extends StatelessWidget {
  final StorageService storageService;
  const KidStoriesApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    final rewardsProvider = RewardsProvider(storageService);
    final authProvider = AuthProvider(storageService);

    // Keep RewardsProvider in sync with auth token so it can cloud-sync
    authProvider.addListener(() {
      rewardsProvider.setAccessToken(authProvider.accessToken);
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => StoryProvider(storageService)),
        ChangeNotifierProvider.value(value: rewardsProvider),
        ChangeNotifierProvider(create: (_) => PurchaseProvider(storageService)),
      ],
      child: MaterialApp(
        title: 'KidStories',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const _Root(),
      ),
    );
  }
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

/// After splash, always go to HomeScreen.
/// Auth is optional — only triggered by premium actions or explicit sign-in.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) => const HomeScreen();
}
