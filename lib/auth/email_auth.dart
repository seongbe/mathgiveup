import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mathgame/api/api.dart';

class EmailAuthService {
  Future<void> sendAndVerifyEmail({
    required String email,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // 이메일 유효성 검사 및 인증 코드 전송
      final url = Uri.parse('$membersUrl/check-email');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'email=${Uri.encodeQueryComponent(email)}',
      );

      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        onSuccess('인증 코드가 이메일로 전송되었습니다.');
      } else {
        print('Error Response Body: ${response.body}');
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
          '$membersUrl/verify-email?email=${Uri.encodeQueryComponent(email)}&code=${Uri.encodeQueryComponent(authCode)}');
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
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
