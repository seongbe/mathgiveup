import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/CertificationPage01.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/loginPage.dart';

class FindIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '아이디 찾기'),
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  String emailErrorMessage = '';
  String birthErrorMessage = '';

  // 백엔드 API 호출
  Future<void> _verifyInput() async {
    setState(() {
      emailErrorMessage = '';
      birthErrorMessage = '';
    });

    // 입력 값 검증
    if (emailController.text.isEmpty) {
      setState(() {
        emailErrorMessage = '이메일을 입력하세요';
      });
      return;
    } else if (birthController.text.isEmpty) {
      setState(() {
        birthErrorMessage = '생년월일을 입력하세요';
      });
      return;
    }

    // URL에 쿼리 파라미터 추가
    final url = Uri.parse(
      'http://192.168.50.195:8080/api/members/find/loginId'
      '?email=${Uri.encodeComponent(emailController.text)}'
      '&birthDate=${Uri.encodeComponent(birthController.text)}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Get.to(CertificationPage01(
        title: '아이디 찾기',
        email: emailController.text,
      ));
    } else {
      Get.to(PopUpPage(
        message: '입력하신 정보와 \n일치하는 아이디가 없습니다!\n\n회원가입을 해주세요!',
        onPressed: () {
          Get.to(LoginPage());
        },
      ));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        birthController.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
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
          SizedBox(height: 100),
          CustomInputField(
            label: '이메일',
            controller: emailController,
            hintText: '이메일을 입력하세요.',
            errorMessage: emailErrorMessage,
          ),
          SizedBox(height: 80),
          CustomInputField(
            label: '생년월일',
            controller: birthController,
            hintText: '생년월일을 선택하세요',
            errorMessage: birthErrorMessage,
            onTap: () => _selectDate(context),
          ),
          SizedBox(height: 120),
          Center(
            child: Container(
              width: 288,
              height: 60,
              child: CustomButton(
                text: '아이디 찾기',
                onPressed: _verifyInput,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
