import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/findPasswdFailPage.dart';
import 'package:mathgame/page/find/certificationPage01.dart';

class FindPasswdPage extends StatelessWidget {
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
  final TextEditingController idController = TextEditingController();
  String errorMessage = '';

  Future<void> _verifyId() async {
    setState(() {
      errorMessage = ''; // 기존의 오류 메시지 초기화
    });

    final id = idController.text;

    if (id.isEmpty) {
      setState(() {
        errorMessage = '아이디를 입력하세요.';
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'http://43.203.199.74:8080/find/pwd/loginId?loginId=${Uri.encodeComponent(id)}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody == 'Login ID exists.') {
          // ID가 유효할 때
          Get.to(CertificationPage01(
            title: '비밀번호 재설정',
            email: '',
          ));
        } else {
          // ID가 유효하지 않을 때
          Get.to(FindPasswdFailPage());
        }
      } else if (response.statusCode == 400) {
        // 사용자 미존재 처리
        setState(() {
          errorMessage = '사용자를 찾을 수 없습니다.';
        });
      } else {
        // 서버 오류 처리
        setState(() {
          errorMessage = '서버 오류가 발생했습니다. 다시 시도해 주세요.';
        });
      }
    } catch (e) {
      // 네트워크 오류 처리
      setState(() {
        errorMessage = '네트워크 오류가 발생했습니다. 다시 시도해 주세요.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 160),
        Align(
          alignment: Alignment.center,
          child: Text(
            '비밀번호를 재설정할 \n SMath 아이디를 입력해주세요',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 25,
            ),
          ),
        ),
        SizedBox(height: 60),
        SizedBox(
          width: 312.84,
          child: CustomTextField(
            controller: idController,
            hintText: '아이디를 입력하세요.',
          ),
        ),
        SizedBox(height: 200),
        Container(
          width: 288,
          height: 60,
          child: CustomButton(
            text: '확인',
            onPressed: _verifyId,
          ),
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
