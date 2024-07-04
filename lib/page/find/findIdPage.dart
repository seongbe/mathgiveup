import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/CertificationPage01.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/loginPage.dart';

class FindIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '아이디 찾기'),
      body: ListView(
        children: [
          MyWidget(),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  String emailErrorMessage = '';
  String birthErrorMessage = '';

  void _verifyInput() {
    setState(() {
      emailErrorMessage = '';
      birthErrorMessage = '';

      if (emailController.text.isEmpty) {
        emailErrorMessage = '이메일을 입력하세요';
      } else if (birthController.text.isEmpty) {
        birthErrorMessage = '생년월일을 입력하세요';
      } else if (emailController.text == 'example@gmail.com' &&
          birthController.text == '240703') {
        Get.to(CertificationPage01(title: '아이디 찾기'));
      } else {
        Get.to(PopUpPage(
          message: '입력하신 정보와 \n일치하는 아이디가 없습니다!\n\n회원가입을 해주세요!',
          onPressed: () {
            Get.to(LoginPage());
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          CustomInputField(
            label: '이메일',
            controller: emailController,
            hintText: '이메일을 입력하세요.',
            errorMessage: emailErrorMessage,
          ),
          SizedBox(height: 80),
          CustomInputField(
            label: '생년월일',
            controller: birthController,
            hintText: '생년월일을 입력하세요.',
            errorMessage: birthErrorMessage,
          ),
          SizedBox(height: 120),
          Center(
            child: Container(
              width: 288,
              height: 60,
              child: CustomButton(
                text: '아이디 찾기',
                onPressed: _verifyInput,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
