import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/findIdPage.dart';
import 'package:mathgame/page/find/findPasswdPage.dart';
import 'package:mathgame/page/join/joinPage.dart';
import 'package:mathgame/page/homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '로그인'),
      body: BackgroundContainer(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
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
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool keepLoggedIn = false;
  String errorMessage = '아이디 또는 비밀번호를 잘못 입력했습니다.';
  Color errorColor = Colors.transparent; //글씨 투명하게 설정

  void _login() {
    setState(() {
      if (idController.text.isEmpty ||
          passwordController.text.isEmpty ||
          idController.text != 'qwer' ||
          passwordController.text != '1234') {
        errorColor = Colors.red;
      } else {
        errorColor = Colors.transparent;
        Get.to(Homepage()); // HomePage로 이동
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 80),
          Text(
            'Smath',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              color: Colors.black,
              fontSize: 55,
              height: 0.01,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 161,
            height: 185,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/청룡.png"),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: errorColor, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          CustomTextField(
            controller: idController,
            hintText: '아이디를 입력하세요.',
          ),
          SizedBox(height: 10),
          CustomTextField(
            controller: passwordController,
            hintText: '비밀번호를 입력하세요.',
            obscureText: true,
          ),
          Row(
            children: [
              Checkbox(
                value: keepLoggedIn,
                onChanged: (bool? value) {
                  setState(() {
                    keepLoggedIn = value!;
                  });
                },
                activeColor: PRIMARY_COLOR,
              ),
              Text(
                '로그인 상태 유지',
                style: skyboriTextStyle,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(FindIdPage());
                },
                child: Text(
                  '아이디 찾기',
                  textAlign: TextAlign.center,
                  style: skyboriUnderlineTextStyle,
                ),
              ),
              Text(
                '/',
                textAlign: TextAlign.center,
                style: skyboriTextStyle,
              ),
              TextButton(
                onPressed: () {
                  Get.to(FindPasswdPage());
                },
                child: Text(
                  '비밀번호 재설정',
                  textAlign: TextAlign.center,
                  style: skyboriUnderlineTextStyle,
                ),
              ),
            ],
          ),
          Container(
            height: 60,
            child: CustomButton(
              text: '시작하기',
              onPressed: _login,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '회원이 아니신가요?',
                textAlign: TextAlign.center,
                style: skyboriTextStyle,
              ),
              TextButton(
                onPressed: () {
                  Get.to(JoinPage());
                },
                child: Text(
                  '회원가입',
                  textAlign: TextAlign.center,
                  style: skyboriUnderlineTextStyle.copyWith(
                    color: PRIMARY_COLOR,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
