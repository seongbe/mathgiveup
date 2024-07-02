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
      appBar: CustomAppBar(title: '아이디 찾기'),
      body: BackgroundContainer(
        child: ListView(
          children: [
            MyWidget(),
          ],
        ),
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
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          child: Stack(
            children: [
              Positioned(
                left: 15,
                top: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이메일',
                      style: skyboriBaseTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    if (emailErrorMessage.isNotEmpty)
                      Text(
                        emailErrorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                  ],
                ),
              ),
              Positioned(
                left: 15,
                top: 235,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: emailController,
                    hintText: '이메일을 입력하세요.',
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 330,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '생년월일',
                      style: skyboriBaseTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    if (birthErrorMessage.isNotEmpty)
                      Text(
                        birthErrorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                  ],
                ),
              ),
              Positioned(
                left: 15,
                top: 365,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: birthController,
                    hintText: '생년월일을 입력하세요.',
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 500,
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
        ),
      ],
    );
  }
}
