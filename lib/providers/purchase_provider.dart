import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class PurchaseProvider extends ChangeNotifier {
  final StorageService _storage;

  PurchaseProvider(this._storage) {
    _loadFromStorage();
  }

  bool _hasPremiumPack = false;
  bool _hasRemovedAds = false;
  bool _temporaryPremium = false; // granted by rewarded ad for current session

  bool get hasPremiumPack => _hasPremiumPack || _temporaryPremium;
  bool get hasRemovedAds => _hasRemovedAds;

  void _loadFromStorage() {
    _hasPremiumPack = _storage.hasPremiumPack;
    _hasRemovedAds = _storage.hasRemovedAds;
  }

  void grantTemporaryPremium() {
    _temporaryPremium = true;
    notifyListeners();
  }
}
