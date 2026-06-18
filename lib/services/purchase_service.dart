import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../constants/app_constants.dart';

typedef PurchaseCallback = void Function(String productId, bool success);

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._();
  factory PurchaseService() => _instance;
  PurchaseService._();

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  List<Package> _packages = [];
  List<Package> get products => _packages;

  Future<void> init(PurchaseCallback onResult) async {
    try {
      // Configure RevenueCat with a guest identifier until user logs in.
      // RevenueCat requires configuration before any call.
      final apiKey = _platformKey();
      if (apiKey.isEmpty) return; // keys not set yet — skip in dev
      await Purchases.configure(PurchasesConfiguration(apiKey));
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      if (current != null) {
        _packages = current.availablePackages;
      }
      _isAvailable = true;
    } catch (_) {
      _isAvailable = false;
    }
  }

  String _platformKey() {
    try {
      if (AppConstants.revenueCatIosKey.startsWith('appl_REPLACE') ||
          AppConstants.revenueCatAndroidKey.startsWith('goog_REPLACE')) {
        return '';
      }
      return Platform.isIOS
          ? AppConstants.revenueCatIosKey
          : AppConstants.revenueCatAndroidKey;
    } catch (_) {
      return '';
    }
  }

  Future<void> buyProduct(String productId) async {
    final pkg = _packages.firstWhere(
      (p) => p.storeProduct.identifier == productId,
      orElse: () => throw StateError('Product $productId not found'),
    );
    await Purchases.purchasePackage(pkg);
  }

  Future<void> restorePurchases() async {
    await Purchases.restorePurchases();
  }

  void dispose() {}
}
