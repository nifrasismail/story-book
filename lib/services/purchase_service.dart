import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../constants/app_constants.dart';

typedef PurchaseCallback = void Function(String productId, bool success);

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._();
  factory PurchaseService() => _instance;
  PurchaseService._();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;

  PurchaseCallback? _onPurchaseResult;

  static const Set<String> _productIds = {
    AppConstants.iapPremiumPack,
    AppConstants.iapRemoveAds,
    AppConstants.iapBundle,
  };

  Future<void> init(PurchaseCallback onResult) async {
    _onPurchaseResult = onResult;
    _isAvailable = await _iap.isAvailable();
    if (!_isAvailable) return;

    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (e) => debugPrint('Purchase stream error: $e'),
    );

    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final response = await _iap.queryProductDetails(_productIds);
    if (response.error != null) {
      debugPrint('IAP query error: ${response.error}');
      return;
    }
    _products = response.productDetails;
  }

  void _onPurchaseUpdate(List<PurchaseDetails> details) {
    for (final purchase in details) {
      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _iap.completePurchase(purchase);
          _onPurchaseResult?.call(purchase.productID, true);
          break;
        case PurchaseStatus.error:
          _onPurchaseResult?.call(purchase.productID, false);
          break;
        default:
          break;
      }
    }
  }

  Future<bool> buyProduct(String productId) async {
    if (!_isAvailable) return false;
    final product = _products.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw StateError('Product $productId not found'),
    );
    final param = PurchaseParam(productDetails: product);
    return _iap.buyNonConsumable(purchaseParam: param);
  }

  Future<void> restorePurchases() async {
    if (!_isAvailable) return;
    await _iap.restorePurchases();
  }

  void dispose() {
    _subscription?.cancel();
  }
}
