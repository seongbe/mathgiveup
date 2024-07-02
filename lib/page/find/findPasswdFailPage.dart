import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/findIdPage.dart';

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
        Container(
          width: 360,
          height: 800,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 220,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '입력하신 정보와 일치하는 \nSMath 계정이 존재하지 않습니다.',
                    textAlign: TextAlign.center,
                    style: skyboriBaseTextStyle.copyWith(
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 470,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '먼저 SMath 아이디 찾기를 시도해 주세요.',
                    textAlign: TextAlign.center,
                    style: skyboriBaseTextStyle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 510,
                child: Container(
                  width: 288,
                  height: 50,
                  child: CustomButton(
                    text: '아이디 찾기',
                    onPressed: () {
                      Get.to(FindIdPage());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
