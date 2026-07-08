import 'package:flutter/foundation.dart';
import '../services/auth_api_service.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService _storage;
  final AuthApiService _api = AuthApiService();

  AuthProvider(this._storage) {
    _restoreSession();
  }

  String? _accessToken;
  String? _refreshToken;
  String? _userId;
  String? _email;
  String? _displayName;
  bool _isLoading = false;
  String? _error;

  bool get isLoggedIn => _accessToken != null;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get accessToken => _accessToken;
  String? get userId => _userId;
  String? get email => _email;
  String? get displayName => _displayName;

  void _restoreSession() {
    _accessToken = _storage.accessToken;
    _refreshToken = _storage.refreshToken;
    _userId = _storage.userId;
    _email = _storage.userEmail;
    _displayName = _storage.displayName;
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await _run(() async {
      final data = await _api.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      await _saveSession(data);
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _run(() async {
      final data = await _api.login(email: email, password: password);
      await _saveSession(data);
    });
  }

  Future<void> logout() async {
    if (_accessToken != null) {
      await _api.logout(_accessToken!);
    }
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
    _email = null;
    _displayName = null;
    await _storage.clearSession();
    notifyListeners();
  }

  Future<bool> refreshSession() async {
    final token = _refreshToken ?? _storage.refreshToken;
    if (token == null) return false;
    try {
      final data = await _api.refresh(token);
      await _saveSession(data);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _saveSession(Map<String, dynamic> data) async {
    _accessToken = data['access_token'] as String;
    _refreshToken = data['refresh_token'] as String;
    _userId = data['user_id'] as String;
    _email = data['email'] as String;
    _displayName = data['display_name'] as String?;
    await _storage.saveSession(
      accessToken: _accessToken!,
      refreshToken: _refreshToken!,
      userId: _userId!,
      email: _email!,
      displayName: _displayName,
    );
  }

  Future<void> _run(Future<void> Function() fn) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await fn();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
