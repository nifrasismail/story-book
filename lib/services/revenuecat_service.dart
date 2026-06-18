import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../constants/app_constants.dart';

class RevenueCatService {
  static bool _configured = false;

  static Future<void> configure(String userId) async {
    if (_configured) {
      await Purchases.logIn(userId);
      return;
    }
    final apiKey = Platform.isIOS
        ? AppConstants.revenueCatIosKey
        : AppConstants.revenueCatAndroidKey;

    await Purchases.configure(
      PurchasesConfiguration(apiKey)..appUserID = userId,
    );
    _configured = true;
  }

  static Future<CustomerInfo> getCustomerInfo() =>
      Purchases.getCustomerInfo();

  static Future<bool> hasPremium() async {
    final info = await getCustomerInfo();
    return info.entitlements.active.containsKey(AppConstants.entitlementPremium);
  }

  static Future<bool> hasNoAds() async {
    final info = await getCustomerInfo();
    return info.entitlements.active.containsKey(AppConstants.entitlementNoAds);
  }

  static Future<CustomerInfo> purchasePackage(Package pkg) =>
      Purchases.purchasePackage(pkg);

  static Future<CustomerInfo> restorePurchases() =>
      Purchases.restorePurchases();

  static Future<List<Offering>> getOfferings() async {
    final offerings = await Purchases.getOfferings();
    return offerings.all.values.toList();
  }
}
