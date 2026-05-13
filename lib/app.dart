import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/purchase_provider.dart';
import 'providers/rewards_provider.dart';
import 'providers/story_provider.dart';
import 'screens/splash_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

class KidStoriesApp extends StatelessWidget {
  final StorageService storageService;
  const KidStoriesApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoryProvider(storageService)),
        ChangeNotifierProvider(create: (_) => RewardsProvider(storageService)),
        ChangeNotifierProvider(create: (_) => PurchaseProvider(storageService)),
      ],
      child: MaterialApp(
        title: 'KidStories',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}
