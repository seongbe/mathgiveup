import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'auth/google_sign_in_provider.dart';
import 'package:mathgame/page/communitypage.dart';
import 'package:mathgame/page/mypage.dart';
import 'package:mathgame/page/odabnotepage.dart';
import 'package:mathgame/page/homepage.dart';
import 'package:mathgame/page/titlepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Titlepage(),
        routes: {
          '/home': (context) => Homepage(), // HomePage 경로를 맞게 변경
        },
      ),
    );
  }
}
