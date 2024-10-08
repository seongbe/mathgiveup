import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoSignProvider {
  signWithKakao() async {
    final UserApi api = UserApi.instance;
    if (await isKakaoTalkInstalled()) {
      try {
        api.loginWithKakaoTalk().then((_) {
          return api.me();
        });
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return api.me();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        return api.me();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
  // Future<void> login() async {
  //   // 카카오톡 설치 여부 확인
  //   bool isKakaoTalkInstalled = await isKakaoTalkInstalled();

  //   if (isKakaoTalkInstalled) {
  //     try {
  //       // 카카오톡으로 로그인 시도
  //       await UserApi.instance.loginWithKakaoTalk();
  //       print('카카오톡으로 로그인 성공');
  //     } catch (error) {
  //       print('카카오톡으로 로그인 실패 $error');

  //       // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우
  //       if (error is PlatformException && error.code == 'CANCELED') {
  //         return;
  //       }

  //       // 카카오톡에 연결된 카카오 계정이 없는 경우 카카오 계정으로 로그인 시도
  //       try {
  //         await UserApi.instance.loginWithKakaoAccount();
  //         print('카카오계정으로 로그인 성공');
  //       } catch (error) {
  //         print('카카오계정으로 로그인 실패 $error');
  //       }
  //     }
  //   } else {
  //     // 카카오톡이 설치되어 있지 않으면 카카오 계정으로 로그인 시도
  //     try {
  //       await UserApi.instance.loginWithKakaoAccount();
  //       print('카카오계정으로 로그인 성공');
  //     } catch (error) {
  //       print('카카오계정으로 로그인 실패 $error');
  //     }
  //   }
  // }
}
