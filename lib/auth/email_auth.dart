import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendSignInLinkToEmail({
    required String email,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      ActionCodeSettings actionCodeSettings = ActionCodeSettings(
        url:
            'https://yourapp.page.link', // 여기를 실제 Firebase Dynamic Link로 대체하세요 싫어!!!!!!!
        handleCodeInApp: true,
        iOSBundleId: 'com.example.ios',
        androidPackageName: 'com.example.android',
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );

      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );

      onSuccess('인증 이메일이 전송되었습니다.');
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> signInWithEmailLink({
    required String email,
    required String emailLink,
    required Function(User?) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        onSuccess(user);
      } else {
        onError('이메일 인증이 완료되지 않았습니다.');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
