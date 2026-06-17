import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'services/notification_service.dart';
import 'services/remote_config_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock portrait orientation for a better reading experience
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Fetch remote config (ads toggle, etc.)
  await RemoteConfigService().fetch();

  // Initialise AdMob
  await MobileAds.instance.initialize();

  // Initialise persistent storage
  final storageService = StorageService();
  await storageService.init();

  // Schedule daily story reminder notification
  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.scheduleDailyReminder();

  runApp(KidStoriesApp(storageService: storageService));
}
