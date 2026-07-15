import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'services/network_service.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Only storage is required before runApp — everything else runs in background
  final storageService = StorageService();
  await storageService.init();

  runApp(KidStoriesApp(storageService: storageService));

  // Non-critical services initialised after the first frame is rendered
  NetworkService().init();
  NotificationService().init().then((_) => NotificationService().scheduleDailyReminder());
}
