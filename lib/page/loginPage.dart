import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/findIdPage.dart';
import 'package:mathgame/page/findPasswdPage.dart';
import 'package:mathgame/page/joinPage.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: BACKGROUND_COLOR,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Skybori'),
          bodyMedium: TextStyle(fontFamily: 'Skybori'),
        ),
      ),
      home: Scaffold(
        body: ListView(
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
                top: 376,
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
                top: 438,
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
                left: 25,
                top: 484,
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
                top: 530,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FindIdPage()),
                              );
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FindPasswdPage()),
                              );
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
                top: 570,
                child: Container(
                  width: 288,
                  height: 50,
                  child: CustomButton(
                    text: '시작하기',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JoinPage(), // Navigate to SignUpPage
                          ),
                        );
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
