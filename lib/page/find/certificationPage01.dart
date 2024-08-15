import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mathgame/const/api.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/certificationPage02.dart';

class CertificationPage01 extends StatelessWidget {
  final String title;
  final String email;
  final String loginId;

  const CertificationPage01({
    Key? key,
    required this.title,
    required this.email,
    required this.loginId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: title),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MyWidget(title: title, email: email, loginId: loginId),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String title;
  final String email;
  final String loginId;

  const MyWidget({
    Key? key,
    required this.title,
    required this.email,
    required this.loginId,
  }) : super(key: key);

  Future<void> _sendCode() async {
    try {
      final url = Uri.parse(
          '$membersUrl/find/send/email?email=${Uri.encodeQueryComponent(email)}');
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      // 디버깅
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Snackbar를 사용하여 사용자에게 메시지를 표시
        Get.snackbar(
          '인증 메일 발송',
          '입력하신 이메일로 인증번호가 발송되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2), // 메시지가 2초 동안 표시됩니다.
          backgroundColor: Colors.white,
          colorText: Colors.black,
          borderRadius: 10,
          margin: EdgeInsets.all(16),
        );

        // 메시지가 표시된 후 자동으로 페이지를 이동
        Future.delayed(Duration(seconds: 2), () {
          Get.to(CertificationPage02(
              title: title, email: email, loginId: loginId));
        });
      } else {
        print('Error sending authentication code to email');
      }
    } catch (e) {
      print('Error sending authentication code to email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 150),
        Align(
          alignment: Alignment.center,
          child: Text(
            '가입하신 이메일로\n인증번호를 보내드릴까요?',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 27,
            ),
          ),
        ),
        SizedBox(height: 100),
        Align(
          alignment: Alignment.center,
          child: Text(
            email,
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 150),
        Center(
          child: Container(
            width: 288,
            height: 60,
            child: CustomButton(
              text: '인증 메일 받기',
              onPressed: _sendCode,
            ),
          ),
        ),
      ],
    );
  }
}
