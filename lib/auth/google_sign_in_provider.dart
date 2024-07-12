import 'package:flutter/material.dart';
import 'package:mathgame/auth/auth_service.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> signInWithGoogle(BuildContext context) async {
    final user = await _authService.signInWithGoogle();
    if (user != null) {
      // 로그인 성공 후 HomePage로 이동
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // 로그인 실패 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google 로그인에 실패했습니다. 다시 시도해주세요.')),
      );
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
