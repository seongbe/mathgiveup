import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:mathgame/page/communitypage.dart';
import 'package:mathgame/page/mypage.dart';
import 'package:mathgame/page/odabnotepage.dart';
import 'package:mathgame/page/homepage.dart'; // 추가
import 'package:mathgame/page/titlepage.dart'; // 추가

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Titlepage(),
    );
  }
}
