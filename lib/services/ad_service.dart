import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/app_constants.dart';

class AdService {
  static final AdService _instance = AdService._();
  factory AdService() => _instance;
  AdService._();

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  // ── Interstitial ───────────────────────────────────────────────────────────
  Future<void> loadInterstitial() async {
    final unitId = Platform.isIOS
        ? AppConstants.interstitialAdUnitIos
        : AppConstants.interstitialAdUnitAndroid;

    await InterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          debugPrint('Interstitial failed to load: $error');
        },
      ),
    );
  }

  void showInterstitial({VoidCallback? onDismissed}) {
    if (_interstitialAd == null) {
      onDismissed?.call();
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        onDismissed?.call();
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        onDismissed?.call();
      },
    );
    _interstitialAd!.show();
  }

  // ── Rewarded ───────────────────────────────────────────────────────────────
  Future<void> loadRewardedAd() async {
    final unitId = Platform.isIOS
        ? AppConstants.rewardedAdUnitIos
        : AppConstants.rewardedAdUnitAndroid;

    await RewardedAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd = ad,
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          debugPrint('Rewarded ad failed to load: $error');
        },
      ),
    );
  }

  void showRewardedAd({
    required void Function(RewardItem reward) onRewarded,
    VoidCallback? onDismissed,
  }) {
    if (_rewardedAd == null) {
      onDismissed?.call();
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        onDismissed?.call();
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewardedAd = null;
        onDismissed?.call();
      },
    );
    _rewardedAd!.show(onUserEarnedReward: (_, reward) => onRewarded(reward));
  }

  bool get isRewardedAdReady => _rewardedAd != null;
  bool get isInterstitialReady => _interstitialAd != null;

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}
