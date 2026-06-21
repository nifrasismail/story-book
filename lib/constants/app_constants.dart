class AppConstants {
  // API
  static const String apiBaseUrl = 'https://kidstories-api-412437962167.us-central1.run.app';
  // For local dev use: 'http://10.0.2.2:8080' (Android emulator)
  // For local dev use: 'http://10.0.2.2:8000' (Android) or 'http://localhost:8000' (iOS sim)


  // AdMob
  static const String androidAppId = 'ca-app-pub-5758697051059467~3504933645';
  static const String iosAppId = 'ca-app-pub-3940256099942544~1458002511'; // update on iOS release

  static const String bannerAdUnitAndroid = 'ca-app-pub-5758697051059467/9077161238';
  static const String bannerAdUnitIos = 'ca-app-pub-3940256099942544/2934735716'; // test — update on iOS release

  static const String interstitialAdUnitAndroid = 'ca-app-pub-5758697051059467/3779726818';
  static const String interstitialAdUnitIos = 'ca-app-pub-3940256099942544/4411468910'; // test — update on iOS release

  static const String rewardedAdUnitAndroid = 'ca-app-pub-5758697051059467/6450997896';
  static const String rewardedAdUnitIos = 'ca-app-pub-3940256099942544/1712485313'; // test — update on iOS release

  // RevenueCat
  static const String revenueCatIosKey = 'appl_REPLACE_WITH_YOUR_IOS_KEY';
  static const String revenueCatAndroidKey = 'goog_REPLACE_WITH_YOUR_ANDROID_KEY';

  // RevenueCat entitlement IDs — must match what you set in RC dashboard
  static const String entitlementPremium = 'premium';
  static const String entitlementNoAds = 'no_ads';

  // IAP product IDs — must match App Store / Play Console entries
  static const String iapPremiumPack = 'premium_stories_pack';
  static const String iapRemoveAds = 'remove_ads';
  static const String iapBundle = 'premium_bundle';

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
