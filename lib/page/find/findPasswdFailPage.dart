import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/findIdPage.dart';
import 'package:mathgame/page/loginPage.dart';

class FindPasswdFailPage extends StatelessWidget {
  const FindPasswdFailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '비밀번호 찾기'),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MyWidget(),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController brithController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 120),
        Align(
          alignment: Alignment.center,
          child: Text(
            '입력하신 정보와 일치하는 \nSMath 계정이 존재하지 않습니다.',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 27,
            ),
          ),
        ),
        SizedBox(height: 150),
        Align(
          alignment: Alignment.center,
          child: Text(
            '먼저 SMath 아이디 찾기를 시도해 주세요.',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 120),
        Center(
          child: Container(
            width: 288,
            height: 60,
            child: CustomButton(
              text: '아이디 찾기',
              onPressed: () {
                Get.to(FindIdPage());
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Container(
            width: 288,
            height: 60,
            child: CustomButton(
              text: '돌아가기',
              onPressed: () {
                Get.to(LoginPage());
              },
            ),
          ),
        ),
      ],
    );
  }
}
