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
            'https://smath.page.link/finishSignUp?email=${email}}', //'http://localhost:5000',
        handleCodeInApp: true,
        iOSBundleId: 'com.hanium.SMath',
        androidPackageName: 'com.hanium.SMath',
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );

      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );

      onSuccess('인증 이메일이 전송되었습니다.');
    } catch (e) {
      print('Error sending sign-in link to email: $e');
      onError('이메일 전송 중 오류가 발생했습니다.');
    }
  }

  Future<void> signInWithEmailLink({
    required String email,
    required String emailLink,
    required Function(User?) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final bool isValidLink = _auth.isSignInWithEmailLink(emailLink);
      if (!isValidLink) {
        onError('유효하지 않은 이메일 링크입니다.');
        return;
      }

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
      print('Error signing in with email link: $e');
      onError('로그인 중 오류가 발생했습니다.');
    }
  }
}
