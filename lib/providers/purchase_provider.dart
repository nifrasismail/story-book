import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class PurchaseProvider extends ChangeNotifier {
  PurchaseProvider(StorageService storage);

  bool get hasPremiumPack => true;
}
