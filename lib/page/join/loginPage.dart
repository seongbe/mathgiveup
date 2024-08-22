import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mathgame/auth/auth_token.dart';
import 'package:mathgame/userInfo/userPreferences.dart';
import 'package:mathgame/api/api.dart';
import 'package:mathgame/page/join/joinPage02.dart';
import 'package:provider/provider.dart';
import 'package:mathgame/auth/google_sign_in_provider.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/findIdPage.dart';
import 'package:mathgame/page/find/findPasswdPage.dart';
import 'package:mathgame/page/join/joinPage.dart';
import 'package:mathgame/router/homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '로그인',
          style: skyboriBaseTextStyle.copyWith(fontSize: 30),
        ),
        leading: Container(),
      ), //CustomAppBar(title: '로그인'),
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
  String errorMessage = '아이디 또는 비밀번호를 다시 확인해 주세요';
  String _message = '';
  Color errorColor = Colors.transparent;

  // 백엔드 API 호출
  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('$membersUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'login_id': idController.text,
        'login_pwd': passwordController.text,
        'autoLogin': keepLoggedIn,
      }),
    );
    // 디버깅
    print('Response headers: ${response.headers}');
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode != 200) {
      var decodedBody = jsonDecode(response.body);
      print('Error message: ${decodedBody['error_message']}');
      print('Error code: ${decodedBody['error_code']}');
    }

    if (response.statusCode == 200) {
      // 수동으로 UTF-8 디코딩
      var rawString = response.body;
      var decodedString = utf8.decode(rawString.codeUnits);
      print('Decoded string: $decodedString');

      // JSON 디코딩
      final data = jsonDecode(decodedString);
      final token = data['token'];
      final nickname = data['nickname'];

      // 닉네임과 토큰 처리
      await AuthTokenStorage.saveToken(token);
      await UserPreferences.saveNickname(nickname);

      // 페이지 이동
      setState(() {
        Get.to(() => Homepage()); // HomePage로 이동
      });
    } else {
      setState(() {
        errorColor = Colors.red;
      });
    }
  }

  // 소셜 로그인 버튼
  Widget snsButton(
      {required String assetPath,
      required VoidCallback onTap,
      required Color backgroundColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Text(
            'Smath',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              color: Colors.black,
              fontSize: 45,
              height: 0.01,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/청룡.png"),
              ),
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              snsButton(
                assetPath: 'assets/images/google.png',
                onTap: () =>
                    Provider.of<GoogleSignInProvider>(context, listen: false)
                        .signInWithGoogle(context),
                backgroundColor: Colors.white,
              ),
              SizedBox(width: 30),
              snsButton(
                assetPath: 'assets/images/kakao_talk.png',
                onTap: () {
                  print('Kakao Sign In Button Pressed');
                },
                backgroundColor: Colors.yellow,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(() => FindIdPage());
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
                  Get.to(() => FindPasswdPage());
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
                  Get.to(() => JoinPage());
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
