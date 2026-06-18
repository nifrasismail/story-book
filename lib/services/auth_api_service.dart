import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

class AuthApiService {
  final String _base = AppConstants.apiBaseUrl;

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final resp = await http.post(
      Uri.parse('$_base/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'display_name': displayName,
      }),
    );
    return _handle(resp);
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final resp = await http.post(
      Uri.parse('$_base/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _handle(resp);
  }

  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    final resp = await http.post(
      Uri.parse('$_base/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );
    return _handle(resp);
  }

  Future<void> logout(String accessToken) async {
    await http.post(
      Uri.parse('$_base/auth/logout'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  Future<Map<String, dynamic>> me(String accessToken) async {
    final resp = await http.get(
      Uri.parse('$_base/auth/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return _handle(resp);
  }

  Map<String, dynamic> _handle(http.Response resp) {
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode >= 400) {
      throw Exception(body['detail'] ?? 'Request failed');
    }
    return body;
  }
}
