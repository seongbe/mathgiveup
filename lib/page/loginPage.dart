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
                left: 100,
                top: 117,
                child: Container(
                  width: 161,
                  height: 185,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/청룡.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 101,
                child: Text(
                  'Smath',
                  textAlign: TextAlign.center,
                  style: skyboriBaseTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 55,
                    height: 0.01,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 350,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: idController,
                    hintText: '아이디를 입력하세요.',
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 410,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: passwordController,
                    hintText: '비밀번호를 입력하세요.',
                    obscureText: true,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 450,
                child: Row(
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
              ),
              Positioned(
                left: 80,
                top: 520,
                child: Container(
                  width: 248,
                  height: 89.01,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 560,
                child: Container(
                  width: 288,
                  height: 60,
                  child: CustomButton(
                    text: '시작하기',
                    onPressed: () {
                      Get.to(Homepage()); // HomePage로 이동
                    },
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 610,
                child: Row(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
