import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mathgame/api/api.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/test/mainTestPage.dart';

class JoinProcess {
  final grades = ['1학년', '2학년', '3학년'];
  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController passwordController;
  final TextEditingController checkPasswordController;
  final TextEditingController nicknameController;
  final TextEditingController birthController;

  JoinProcess({
    required this.nameController,
    required this.idController,
    required this.passwordController,
    required this.checkPasswordController,
    required this.nicknameController,
    required this.birthController,
  });

  String idErrorMessage = '';
  Color idErrorColor = Colors.red;
  bool isIdVerified = false;
  int selectedButtonIndex = -1;
  String email = '';

  void initEmail(String userEmail) {
    email = userEmail;
  }

  Future<void> checkID(List<String> existingIds, State state) async {
    try {
      final url = Uri.parse(
        '$membersUrl/check-loginId'
        '?loginId=${Uri.encodeComponent(idController.text)}',
      );

      print('Requesting: $url'); // URL 출력

      final response = await http.post(url);

      print('Response status code: ${response.statusCode}'); // 상태 코드 출력
      print('Response body: ${response.body}'); // 응답 본문 출력

      if (idController.text.isEmpty) {
        idErrorMessage = '아이디를 입력해 주세요.';
        idErrorColor = Colors.red;
        isIdVerified = false;
      } else if (response.statusCode == 200) {
        idErrorMessage = '사용 가능한 아이디입니다.';
        idErrorColor = Colors.blue;
        isIdVerified = true;
      } else {
        idErrorMessage = '이미 사용 중인 아이디입니다.';
        idErrorColor = Colors.red;
        isIdVerified = false;
      }
    } catch (e) {
      print('Error occurred: $e'); // 예외 메시지 출력
      idErrorMessage = '아이디 확인 중 오류가 발생했습니다. 인터넷 연결을 확인하세요.';
      idErrorColor = Colors.red;
      isIdVerified = false;
    }

    // UI 갱신
    state.setState(() {});
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> checkField(BuildContext context) async {
    if (idController.text.isEmpty) {
      showSnackBar(context, '아이디를 입력해 주세요.');
      isIdVerified = false;
    } else if (!isIdVerified) {
      showSnackBar(context, '아이디 중복 검사를 해주세요');
    } else if (passwordController.text.isEmpty ||
        checkPasswordController.text.isEmpty) {
      showSnackBar(context, '비밀번호를 입력해주세요.');
    } else if (passwordController.text != checkPasswordController.text) {
      showSnackBar(context, '비밀번호를 다시 확인해주세요.');
    } else if (nicknameController.text.isEmpty) {
      showSnackBar(context, '닉네임을 입력해 주세요.');
    } else if (birthController.text.isEmpty) {
      showSnackBar(context, '생일을 입력해 주세요.');
    } else if (selectedButtonIndex == -1) {
      showSnackBar(context, '학년을 선택해 주세요.');
    } else {
      final url = Uri.parse('$membersUrl/signup');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': nameController.text,
          'loginId': idController.text,
          'loginPwd': passwordController.text,
          'nickname': nicknameController.text,
          'grade': selectedButtonIndex,
          'birthdate': birthController.text,
        }),
      );
      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        Get.to(PopUpPage(
          message: '회원가입이 완료되었습니다.\n확인 버튼을 누르면 실력테스트로 넘어갑니다.',
          onPressed: () {
            Get.to(MainTestPage());
          },
        ));
      } else {
        print('Response Body: ${response.body}');
        showSnackBar(context, '회원가입에 실패했습니다. 다시 시도해 주세요.');
      }
    }
  }

  Future<void> selectDate(BuildContext context, State state) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      birthController.text =
          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

      state.setState(() {});
    }
  }
}
