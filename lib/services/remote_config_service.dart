import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._();

  bool _adsEnabled = true;

  bool get adsEnabled => _adsEnabled;

  Future<void> fetch() async {
    try {
      final response = await http
          .get(Uri.parse('${AppConstants.apiBaseUrl}/config/'))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        _adsEnabled = data['ads_enabled'] as bool? ?? true;
      }
    } catch (e) {
      debugPrint('RemoteConfig fetch failed, using defaults: $e');
    }
  }
}
