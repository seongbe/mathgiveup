import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/loginPage.dart';

class FindPasswdPage02 extends StatelessWidget {
  const FindPasswdPage02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '비밀번호 재설정'),
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
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  bool keepLoggedIn = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          CustomInputField(
            label: '새 비밀번호',
            controller: passwordController1,
            hintText: '새 비밀번호를 입력하세요.',
            errorMessage: errorMessage,
            obscureText: true,
          ),
          SizedBox(height: 80),
          CustomInputField(
            label: '새 비밀번호 확인',
            controller: passwordController2,
            hintText: '비밀번호를 한 번 더 입력하세요.',
            errorMessage: '',
            obscureText: true,
          ),
          SizedBox(height: 120),
          Center(
            child: Container(
              width: 288,
              height: 60,
              child: CustomButton(
                text: '비밀번호 변경',
                onPressed: _resetPassword,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetPassword() {
    if (passwordController1.text.isEmpty || passwordController2.text.isEmpty) {
      setState(() {
        errorMessage = '비밀번호를 입력해주세요.';
        passwordController1.clear();
        passwordController2.clear();
      });
    } else if (passwordController1.text == passwordController2.text) {
      Get.to(PopUpPage(
        message: '비밀번호 변경이 완료되었습니다.\n다시 로그인해주세요!',
        onPressed: () {
          Get.to(LoginPage());
        },
      ));
    } else {
      setState(() {
        errorMessage = '비밀번호를 다시 확인해주세요.';
        passwordController1.clear();
        passwordController2.clear();
      });
    }
  }
}
