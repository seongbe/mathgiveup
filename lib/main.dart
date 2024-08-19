import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mathgame/page/join/loginPage.dart';
import 'controller/firebase_options.dart'; // Firebase 초기화 옵션 파일
import 'package:provider/provider.dart';
import 'auth/google_sign_in_provider.dart';
import 'package:mathgame/page/community/communitypage.dart';
import 'package:mathgame/page/mypage/mypage.dart';
import 'package:mathgame/page/odabnote/odabnotepage.dart';
import 'package:mathgame/router/homepage.dart';
import 'package:mathgame/page/join/titlepage.dart';
import 'package:mathgame/model/progressModel.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart'; // 카카오

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Firebase 에뮬레이터 설정
  FirebaseFirestore.instance.settings = const Settings(
    host: 'localhost:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  ); // 이 설정을 통해 Firestore가 로컬 에뮬레이터를 사용하도록 지정

  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'b27c9e44a65488be85a63f8ccb4ee727',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => ProgressModel()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Titlepage(),
        routes: {
          '/home': (context) => Homepage(), // HomePage 경로를 맞게 변경
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
