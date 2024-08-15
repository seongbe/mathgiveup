import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mathgame/const/api.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/loginPage.dart';

class FindPasswdPage02 extends StatelessWidget {
  final String email;
  final String code;

  const FindPasswdPage02({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '비밀번호 재설정'),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MyWidget(email: email, code: code),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String email;
  final String code;

  const MyWidget({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
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

  Future<void> _resetPassword() async {
    final newPassword = passwordController1.text;
    final confirmPassword = passwordController2.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorMessage = '비밀번호를 입력해주세요.';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        errorMessage = '비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    try {
      final url = Uri.parse(
          '$membersUrl/reset/password/change?email=${Uri.encodeQueryComponent(widget.email)}&new_password=${Uri.encodeQueryComponent(newPassword)}&code=${Uri.encodeQueryComponent(widget.code)}');
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      // 디버깅
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Get.to(PopUpPage(
            message: '비밀번호 변경이 완료되었습니다.\n다시 로그인해주세요!',
            onPressed: () {
              Get.to(LoginPage());
            }));
      } else {
        setState(() {
          errorMessage = '비밀번호 변경에 실패했습니다.';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        errorMessage = '비밀번호 변경 중 오류가 발생했습니다.';
      });
    }
  }
}
