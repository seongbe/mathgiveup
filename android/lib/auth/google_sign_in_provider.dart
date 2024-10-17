// import 'package:flutter/material.dart';
// import 'auth_service.dart';

// class GoogleSignInProvider extends ChangeNotifier {
//   final AuthService _authService = AuthService();

//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final user = await _authService.signInWithGoogle(context);
//       if (user != null) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Google 로그인에 실패했습니다. 다시 시도해주세요.')),
//         );
//       }
//     } catch (error) {
//       print("Sign-in error: $error");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('로그인 중 오류가 발생했습니다.')),
//       );
//     }
//   }

//   Future<void> signOut() async {
//     await _authService.signOut();
//   }
// }
