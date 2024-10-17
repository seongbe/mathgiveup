import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStorage {
  static final _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  // 토큰 저장
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // 토큰 읽기
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // 토큰 삭제
  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
