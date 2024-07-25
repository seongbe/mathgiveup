import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final TextEditingController emailLinkController = TextEditingController();
  String emailErrorMessage = '';
  String authMessage = '';
  Color codeErrorColor = Colors.grey;
  bool isEmailSent = false; // 이메일 전송 여부를 추적하는 변수
  bool isEmailVerified = false; // 이메일 인증 여부를 추적하는 변수

  final EmailAuthService _authService = EmailAuthService();

  void _sendSignInLink() {
    setState(() {
      emailErrorMessage = '';

      if (emailController.text.isEmpty) {
        emailErrorMessage = '이메일을 입력하세요';
      } else {
        _authService.sendSignInLinkToEmail(
          email: emailController.text,
          onSuccess: (message) {
            setState(() {
              emailErrorMessage = message;
              isEmailSent = true; // 이메일 전송 완료로 설정
            });
          },
          onError: (error) {
            setState(() {
              emailErrorMessage = error;
            });
          },
        );
      }
    });
  }

  void _verifyEmailLink() {
    setState(() {
      authMessage = '';
    });

    _authService.signInWithEmailLink(
      email: emailController.text,
      emailLink: emailLinkController.text,
      onSuccess: (user) {
        setState(() {
          authMessage = '이메일 인증이 완료되었습니다!';
          codeErrorColor = Colors.blue;
          isEmailVerified = true; // 이메일 인증 성공으로 설정
        });
      },
      onError: (error) {
        setState(() {
          authMessage = error;
          codeErrorColor = Colors.red;
          isEmailVerified = false; // 이메일 인증 실패로 설정
        });
      },
    );
  }

  void _onNextButtonPressed() {
    if (isEmailVerified) {
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
                text: '인증 메일 받기',
                fontSize: 25,
                onPressed: _sendSignInLink,
              ),
            ),
          ),
          SizedBox(height: 80),
          if (isEmailSent) ...[
            Center(
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailLinkController,
                    hintText: '이메일로 받은 링크를 입력하세요.',
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
                        text: '이메일 인증 확인',
                        fontSize: 25,
                        onPressed: _verifyEmailLink,
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
                onPressed: () {},
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
