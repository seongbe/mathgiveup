import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/join/joinPage02.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '회원가입'),
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
  final TextEditingController codeController = TextEditingController();
  String emailErrorMessage = '';
  String codeErrorMessage = '어떠한 경우에도 타인에게 보여주지마세요.';
  Color codeErrorColor = Colors.grey;
  bool isCodeVerified = false; // 인증 성공 여부를 추적하는 변수

  bool isEmailVerified = false; // 이메일 인증 여부를 추적하는 변수

  void _verifyInputEmail() {
    setState(() {
      emailErrorMessage = '';

      if (emailController.text.isEmpty) {
        emailErrorMessage = '이메일을 입력하세요';
      } else {
        isEmailVerified = true; // 이메일 인증 완료로 설정
        Get.to(PopUpPage(
          message: '입력한 이메일로\n인증번호가 발송되었습니다.',
          onPressed: () {
            Get.back();
          },
        ));
      }
    });
  }

  void _verifyInputCode() {
    setState(() {
      codeErrorMessage = '';

      if (codeController.text.isEmpty) {
        codeErrorMessage = '인증번호를 입력하세요.';
        codeErrorColor = Colors.red;
        isCodeVerified = false; // 인증 실패로 설정
      } else if (codeController.text == '1234') {
        codeErrorMessage = '인증이 완료되었습니다!';
        codeErrorColor = Colors.blue;
        isCodeVerified = true; // 인증 성공으로 설정
      } else {
        codeErrorMessage = '인증번호를 다시 확인해주세요.';
        codeErrorColor = Colors.red;
        isCodeVerified = false; // 인증 실패로 설정
      }
    });
  }

  void _onNextButtonPressed() {
    if (isCodeVerified) {
      Get.to(JoinPage02());
    }
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
                top: 80,
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
                top: 115,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: emailController,
                    hintText: '이메일을 입력하세요.',
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 180,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: CustomButton(
                      text: '인증 메일 받기',
                      fontSize: 25,
                      onPressed: _verifyInputEmail,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '인증번호',
                      style: skyboriBaseTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    if (codeErrorMessage.isNotEmpty)
                      Text(
                        codeErrorMessage,
                        style: TextStyle(
                          color: codeErrorColor,
                          fontSize: 15,
                        ), // 상태에 따라 색상 변경
                      ),
                  ],
                ),
              ),
              Positioned(
                left: 15,
                top: 335,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: codeController,
                    hintText: '인증번호를 입력하세요.',
                    enabled: isEmailVerified, // 이메일 인증 여부에 따라 활성화/비활성화
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 400,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: CustomButton(
                      text: '인증번호 확인',
                      fontSize: 25,
                      onPressed: isEmailVerified
                          ? _verifyInputCode
                          : () {}, // null 대신 빈 함수 전달
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 560,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: CustomButton(
                      text: '동의하고 다음으로',
                      fontSize: 25,
                      onPressed: _onNextButtonPressed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
