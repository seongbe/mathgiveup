import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/find/certificationPage02.dart';

class CertificationPage01 extends StatelessWidget {
  final String title;

  const CertificationPage01({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: title),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MyWidget(title: title),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String title;

  MyWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 150),
        Align(
          alignment: Alignment.center,
          child: Text(
            '가입하신 이메일로\n인증번호를 보내드릴까요?',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 27,
            ),
          ),
        ),
        SizedBox(height: 100),
        Align(
          alignment: Alignment.center,
          child: Text(
            'example@gmail.com',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 150),
        Center(
          child: Container(
            width: 288,
            height: 60,
            child: CustomButton(
              text: '인증 메일 받기',
              onPressed: () {
                Get.to(() => PopUpPage(
                      message: '입력하신 이메일로\n인증번호가 발송되었습니다.',
                      onPressed: () {
                        Get.to(CertificationPage02(title: title));
                      },
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
