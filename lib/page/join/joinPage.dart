import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/Notification/personalInfoPage.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/join/joinPage02.dart';
import 'package:mathgame/auth/email_auth.dart'; // EmailAuth

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
        padding: const EdgeInsets.all(16.0),
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
  final TextEditingController authCodeController = TextEditingController();
  String emailErrorMessage = '';
  String authMessage = '';
  Color codeErrorColor = Colors.grey;
  bool isAuthCodeSent = false; // 인증 코드 전송 여부를 추적하는 변수
  bool isAuthCodeVerified = false; // 인증 코드 검증 여부를 추적하는 변수

  final EmailAuthService _authService = EmailAuthService();

  Future<void> _sendAuthCode() async {
    setState(() {
      emailErrorMessage = '';
    });

    if (emailController.text.isEmpty) {
      setState(() {
        emailErrorMessage = '이메일을 입력하세요';
      });
      return;
    }

    _authService.sendAndVerifyEmail(
      email: emailController.text,
      onSuccess: (message) {
        setState(() {
          emailErrorMessage = message;
          isAuthCodeSent = true; // 인증 코드 전송 완료로 설정
        });
      },
      onError: (error) {
        setState(() {
          emailErrorMessage = error;
        });
      },
    );
  }

  void _verifyAuthCode() {
    setState(() {
      authMessage = '';
    });

    _authService.verifyAuthCode(
      email: emailController.text,
      authCode: authCodeController.text,
      onSuccess: (message) {
        setState(() {
          authMessage = '이메일 인증이 완료되었습니다!';
          codeErrorColor = Colors.blue;
          isAuthCodeVerified = true; // 인증 코드 검증 성공으로 설정
        });
      },
      onError: (error) {
        setState(() {
          authMessage = error;
          codeErrorColor = Colors.red;
          isAuthCodeVerified = false; // 인증 코드 검증 실패로 설정
        });
      },
    );
  }

  void _onNextButtonPressed() {
    if (isAuthCodeVerified) {
      Get.to(JoinPage02(), arguments: emailController.text.trim());
    } else {
      setState(() {
        authMessage = '이메일 인증을 완료해주세요.';
        codeErrorColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이메일',
                style: skyboriBaseTextStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  emailErrorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          CustomTextField(
            controller: emailController,
            hintText: '이메일을 입력하세요.',
          ),
          SizedBox(height: 15),
          Center(
            child: Container(
              width: 250,
              height: 50,
              child: CustomButton(
                text: '인증 코드 받기',
                fontSize: 25,
                onPressed: _sendAuthCode,
              ),
            ),
          ),
          SizedBox(height: 80),
          if (isAuthCodeSent) ...[
            Center(
              child: Column(
                children: [
                  CustomTextField(
                    controller: authCodeController,
                    hintText: '이메일로 받은 인증 코드를 입력하세요.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    authMessage,
                    style: TextStyle(
                      color: codeErrorColor,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 250,
                      height: 50,
                      child: CustomButton(
                        text: '인증 코드 확인',
                        fontSize: 25,
                        onPressed: _verifyAuthCode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '이용약관',
                  textAlign: TextAlign.center,
                  style: skyboriUnderlineTextStyle,
                ),
              ),
              Text(
                '및',
                textAlign: TextAlign.center,
                style: skyboriTextStyle,
              ),
              TextButton(
                onPressed: () {
                  PersonalInfo(context);
                },
                child: Text(
                  '개인정보취급방침',
                  textAlign: TextAlign.center,
                  style: skyboriUnderlineTextStyle,
                ),
              ),
            ],
          ),
          Center(
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
