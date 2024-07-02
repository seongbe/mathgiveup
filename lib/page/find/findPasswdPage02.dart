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
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          child: Stack(
            children: [
              Positioned(
                left: 15,
                top: 150,
                child: Text('새 비밀번호',
                    style: skyboriBaseTextStyle.copyWith(
                      fontSize: 20,
                    )),
              ),
              Positioned(
                left: 15,
                top: 185,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: passwordController1,
                    hintText: '새 비밀번호를 입력하세요.',
                    obscureText: true,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 300,
                child: Text(
                  '새 비밀번호 확인',
                  style: skyboriBaseTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 335,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: passwordController2,
                    hintText: '새 비밀번호를 한 번 더 입력하세요.',
                    obscureText: true,
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
                    text: '비밀번호 재설정',
                    onPressed: _resetPassword,
                  ),
                ),
              ),
              if (errorMessage.isNotEmpty)
                Positioned(
                  left: 34,
                  top: 570,
                  right: 34,
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ],
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
        message: '비밀번호 재설정이 완료되었습니다.\n다시 로그인해주세요!',
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
