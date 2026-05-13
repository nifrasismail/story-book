import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../services/purchase_service.dart';
import '../services/storage_service.dart';

class PurchaseProvider extends ChangeNotifier {
  final StorageService _storage;
  final PurchaseService _purchaseService = PurchaseService();

  PurchaseProvider(this._storage) {
    _loadFromStorage();
    _initIap();
  }

  bool _hasPremiumPack = false;
  bool _hasRemovedAds = false;
  bool _isLoading = false;
  String? _error;

  bool get hasPremiumPack => _hasPremiumPack;
  bool get hasRemovedAds => _hasRemovedAds;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isIapAvailable => _purchaseService.isAvailable;
  List get products => _purchaseService.products;

  void _loadFromStorage() {
    _hasPremiumPack = _storage.hasPremiumPack;
    _hasRemovedAds = _storage.hasRemovedAds;
  }

  void _initIap() {
    _purchaseService.init((productId, success) {
      if (success) _handlePurchaseSuccess(productId);
      _isLoading = false;
      notifyListeners();
    });
  }

  void _handlePurchaseSuccess(String productId) {
    if (productId == AppConstants.iapPremiumPack ||
        productId == AppConstants.iapBundle) {
      _hasPremiumPack = true;
      _storage.setHasPremiumPack(true);
    }
    if (productId == AppConstants.iapRemoveAds ||
        productId == AppConstants.iapBundle) {
      _hasRemovedAds = true;
      _storage.setHasRemovedAds(true);
    }
    notifyListeners();
  }

  Future<void> purchasePremiumPack() => _doPurchase(AppConstants.iapPremiumPack);
  Future<void> purchaseRemoveAds() => _doPurchase(AppConstants.iapRemoveAds);
  Future<void> purchaseBundle() => _doPurchase(AppConstants.iapBundle);

  Future<void> _doPurchase(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _purchaseService.buyProduct(id);
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> restorePurchases() async {
    _isLoading = true;
    notifyListeners();
    await _purchaseService.restorePurchases();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _purchaseService.dispose();
    super.dispose();
  }
}
