import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mathgame/api/api.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/find/findPasswdPage02.dart';
import 'package:mathgame/page/join/loginPage.dart';

class CertificationPage02 extends StatelessWidget {
  final String title;
  final String email;
  final String loginId;

  const CertificationPage02({
    super.key,
    required this.title,
    required this.email,
    required this.loginId,
  });

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

class MyWidget extends StatefulWidget {
  final String title;
  final String email;
  final String loginId;

  MyWidget({
    required this.title,
    required this.email,
    required this.loginId,
  });
  @override
  _MyWidgetState createState() => _MyWidgetState(
        title: title,
        email: email,
        loginId: loginId,
      );
}

class _MyWidgetState extends State<MyWidget> {
  final String title;
  final String email;
  final String loginId;

  _MyWidgetState({
    required this.title,
    required this.email,
    required this.loginId,
  });
  final TextEditingController codeController1 = TextEditingController();
  final TextEditingController codeController2 = TextEditingController();
  final TextEditingController codeController3 = TextEditingController();
  final TextEditingController codeController4 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();

  String errorMessage = '';

  void _nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      FocusScope.of(focusNode.context!).requestFocus(focusNode);
    }
  }

  void _previousField(String value, FocusNode previousFocus,
      TextEditingController previousController) {
    if (value.isEmpty) {
      previousController.clear();
      FocusScope.of(previousFocus.context!).requestFocus(previousFocus);
    }
  }

  Future<void> _verifyCode() async {
    String code = codeController1.text +
        codeController2.text +
        codeController3.text +
        codeController4.text;

    print('Entered code: $code');

    try {
      final url = Uri.parse(
          '$membersUrl/find/email/verify?email=${Uri.encodeQueryComponent(email)}&code=${Uri.encodeQueryComponent(code)}');
      final response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('${loginId}');

      if (response.statusCode == 200) {
        if (response.body.contains('Verification code valid')) {
          if (title == '비밀번호 재설정') {
            Get.to(PopUpPage(
              message: '인증이 완료되었습니다!',
              onPressed: () {
                Get.to(FindPasswdPage02(email: email, code: code));
              },
            ));
          } else {
            Get.to(PopUpPage(
              message: '회원님의 SMath 아이디는 \n${loginId}입니다!',
              onPressed: () {
                Get.to(LoginPage());
              },
            ));
          }
        } else {
          setState(() {
            errorMessage = '인증번호를 다시 확인해주세요.';
            FocusScope.of(context).requestFocus(focusNode1);
            codeController1.clear();
            codeController2.clear();
            codeController3.clear();
            codeController4.clear();
          });
        }
      } else {
        setState(() {
          errorMessage = '인증 오류가 발생했습니다. 다시 시도해 주세요.';
          FocusScope.of(context).requestFocus(focusNode1);
          codeController1.clear();
          codeController2.clear();
          codeController3.clear();
          codeController4.clear();
        });
      }
    } catch (e) {
      print('Error verifying authentication code: $e');
      setState(() {
        errorMessage = '인증 코드 확인 중 오류가 발생했습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100),
        Align(
          alignment: Alignment.center,
          child: Text(
            '메일 확인 후\n인증번호 4자리를 입력해주세요.',
            textAlign: TextAlign.center,
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 27,
            ),
          ),
        ),
        SizedBox(height: 70),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(codeController1, focusNode1, focusNode2, null),
                _buildTextField(
                    codeController2, focusNode2, focusNode3, focusNode1),
                _buildTextField(
                    codeController3, focusNode3, focusNode4, focusNode2),
                _buildTextField(codeController4, focusNode4, null, focusNode3),
              ],
            ),
          ],
        ),
        SizedBox(height: 120),
        TextButton(
          onPressed: () {
            Get.back(); // 인증번호 다시 받기 로직으로 바꾸기
          },
          child: Text(
            '인증번호 다시 받기',
            textAlign: TextAlign.center,
            style: skyboriUnderlineTextStyle.copyWith(
              color: PRIMARY_COLOR,
            ),
          ),
        ),
        Container(
          width: 288,
          height: 60,
          child: CustomButton(
            text: '인증하기',
            onPressed: _verifyCode,
          ),
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  // 인증번호 입력 위젯
  Widget _buildTextField(TextEditingController controller,
      FocusNode currentFocus, FocusNode? nextFocus, FocusNode? previousFocus) {
    return Container(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && nextFocus != null) {
            FocusScope.of(currentFocus.context!).requestFocus(nextFocus);
          } else if (value.isEmpty && previousFocus != null) {
            _previousField(value, previousFocus, controller);
          }
        },
        onSubmitted: (value) {
          if (value.isEmpty && previousFocus != null) {
            _previousField(value, previousFocus, controller);
          }
        },
      ),
    );
  }
}
