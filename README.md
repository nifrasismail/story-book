# KidStories 📚

A magical, colorful storybook Flutter app for children — packed with 20 classic stories, a rewards system, push notifications, AdMob integration, and in-app purchases.

---

## Features

| Feature | Details |
|---|---|
| 📖 20 Stories | 10 free classics + 10 premium fairy tales & adventures |
| ⭐ Rewards System | Stars, levels (1–10), 12 badges, reading streak |
| 🔔 Push Notifications | Daily story reminder at 5 PM |
| 💎 In-App Purchases | Premium Pack ($4.99), Remove Ads ($2.99), Bundle ($6.99) |
| 📺 AdMob | Banner + interstitial + rewarded ads |
| 🎨 Kid-Friendly UI | Colorful gradients, emoji illustrations, animations |

---

## Quick Start

```bash
# 1. Install Flutter (https://flutter.dev/docs/get-started/install)
flutter --version   # Requires 3.3.0+

# 2. Get dependencies
flutter pub get

# 3. Run on a device / simulator
flutter run
```

---

## Before Publishing

### AdMob
1. Create an AdMob account at https://admob.google.com
2. Create an App and four ad units (Banner, Interstitial, Rewarded × 2 platforms)
3. Replace the test IDs in `lib/constants/app_constants.dart`:
   - `androidAppId` / `iosAppId`
   - `bannerAdUnit*`, `interstitialAdUnit*`, `rewardedAdUnit*`
4. Replace the `APPLICATION_ID` in `android/app/src/main/AndroidManifest.xml`
5. Replace `GADApplicationIdentifier` in `ios/Runner/Info.plist`

### In-App Purchases
1. Create products in App Store Connect and Google Play Console with these IDs:
   - `premium_stories_pack`
   - `remove_ads`
   - `premium_bundle`
2. Prices: $4.99 / $2.99 / $6.99 (adjust in `lib/screens/store_screen.dart`)

### Firebase Cloud Messaging (optional upgrade)
Currently uses local notifications. To add FCM for server-side reminders,
add `firebase_messaging` and `firebase_core` to `pubspec.yaml` and drop
`google-services.json` into `android/app/`.

---

## Project Structure

```
lib/
├── main.dart               # App entry point
├── app.dart                # MaterialApp + providers
├── constants/              # Colors, ad IDs, IAP IDs
├── models/                 # Story, Badge, UserProgress
├── data/                   # 20 hard-coded kids stories
├── services/               # Storage, Notifications, AdMob, IAP
├── providers/              # Story, Rewards, Purchase state
├── screens/                # Splash, Home, Reader, Rewards, Store
├── widgets/                # StoryCard, Badge, StarCounter, AdBanner
└── theme/                  # AppTheme (Nunito font, color scheme)
```

---

## Revenue Strategy

- **Free tier**: 10 stories + banner/interstitial ads
- **Remove Ads** ($2.99): removes all ads
- **Premium Pack** ($4.99): unlocks 10 premium stories
- **Bundle** ($6.99): both above — best value
- **Rewarded Ads**: watch a video to unlock one premium story for free (re-engagement)

---

## License

MIT
