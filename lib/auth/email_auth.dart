import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailAuthService {
  final String baseUrl = 'http://192.168.50.195:8080/api/members';

  Future<bool> emailVail({required String email}) async {
    try {
      final url = Uri.parse('$baseUrl/sendCode');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'email=${Uri.encodeQueryComponent(email)}',
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error sending authentication code to email: $e');
      return false;
    }
  }

  Future<void> sendAuthCode({
    required String email,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/sendCode');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'email=${Uri.encodeQueryComponent(email)}',
      );

      if (response.statusCode == 200) {
        onSuccess('인증 코드가 이메일로 전송되었습니다.');
      } else {
        onError('인증 코드 전송 중 오류가 발생했습니다.');
      }
    } catch (e) {
      print('Error sending authentication code to email: $e');
      onError('인증 코드 전송 중 오류가 발생했습니다.');
    }
  }

  Future<void> verifyAuthCode({
    required String email,
    required String authCode,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final url = Uri.parse(
          '$baseUrl/verifyCode?email=${Uri.encodeQueryComponent(email)}&authCode=${Uri.encodeQueryComponent(authCode)}');
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode == 200) {
        onSuccess('이메일 인증이 완료되었습니다.');
      } else {
        onError('이메일 인증에 실패했습니다.');
      }
    } catch (e) {
      print('Error verifying authentication code: $e');
      onError('이메일 인증 중 오류가 발생했습니다.');
    }
  }
}
