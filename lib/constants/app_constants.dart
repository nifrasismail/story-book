class AppConstants {
  // API
  static const String apiBaseUrl = 'https://kidstories-api-412437962167.us-central1.run.app';
  // For local dev use: 'http://10.0.2.2:8080' (Android emulator)
  // For local dev use: 'http://10.0.2.2:8000' (Android) or 'http://localhost:8000' (iOS sim)


  // AdMob
  static const String androidAppId = 'ca-app-pub-5758697051059467~3504933645';
  static const String iosAppId = 'ca-app-pub-5758697051059467~7118385763';

  static const String bannerAdUnitAndroid = 'ca-app-pub-5758697051059467/9077161238';
  static const String bannerAdUnitIos = 'ca-app-pub-5758697051059467/6069027971';

  static const String interstitialAdUnitAndroid = 'ca-app-pub-5758697051059467/3779726818';
  static const String interstitialAdUnitIos = 'ca-app-pub-5758697051059467/8469784438';

  static const String rewardedAdUnitAndroid = 'ca-app-pub-5758697051059467/6450997896';
  static const String rewardedAdUnitIos = 'ca-app-pub-5758697051059467/5843621096';

  // Rewards
  static const int starsPerLevel = 15;
  static const int dailyLoginStars = 3;
  static const int streakBonusStars = 2;
  static const int maxLevel = 10;

  // Notifications
  static const int dailyReminderHour = 17;
  static const int dailyReminderMinute = 0;
  static const int notificationId = 1;
}
