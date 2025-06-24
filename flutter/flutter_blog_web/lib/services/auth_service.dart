import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  final _storage = FlutterSecureStorage();
  String? _token;
  String? get token => _token;
  String? get userId => _decoded?['user_id']?.toString();


  Map<String, dynamic>? get _decoded {
    if (_token == null) return null;
    final parts = _token!.split('.');
    if (parts.length != 3) return null;
    final payload = parts[1];
    String normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return json.decode(decoded);
  }

  Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/login/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      _token = data['access'];
      await _storage.write(key: 'jwt', value: _token);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _token = null;
    await _storage.delete(key: 'jwt');
    notifyListeners();
  }
}
