import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/find/findPasswdPage02.dart';
import 'package:mathgame/page/loginPage.dart';

class CertificationPage02 extends StatelessWidget {
  final String title;

  const CertificationPage02({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: title),
      body: ListView(
        children: [
          MyWidget(title: title),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String title;

  MyWidget({required this.title});
  @override
  _MyWidgetState createState() => _MyWidgetState(title: title);
}

class _MyWidgetState extends State<MyWidget> {
  final String title;

  _MyWidgetState({required this.title});
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

  void _verifyCode() {
    String code = codeController1.text +
        codeController2.text +
        codeController3.text +
        codeController4.text;
    // 임시 인증번호
    if (code == '1234') {
      if (title == '비밀번호 재설정') {
        // 비번 재설정인 경우
        Get.to(PopUpPage(
          message: '인증이 완료되었습니다!',
          onPressed: () {
            Get.to(FindPasswdPage02());
          },
        ));
      } else {
        // 아이디 찾기인 겅우
        Get.to(PopUpPage(
          message: '회원님의 SMath 아이디는 \nqwer입니다!',
          onPressed: () {
            Get.to(LoginPage());
          },
        ));
      }
    } else {
      setState(() {
        errorMessage = '인증번호를 다시 확인해주세요.';
        // 첫 번째 입력 필드로 포커스를 이동
        FocusScope.of(context).requestFocus(focusNode1);
        // 입력 필드 초기화
        codeController1.clear();
        codeController2.clear();
        codeController3.clear();
        codeController4.clear();
      });
    }
  }

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
                left: 0,
                right: 0,
                top: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '메일 확인 후\n인증번호 4자리를 입력해주세요.',
                    textAlign: TextAlign.center,
                    style: skyboriBaseTextStyle.copyWith(
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
              // 인증번호 입력
              Positioned(
                left: 34,
                right: 34,
                top: 250,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTextField(
                            codeController1, focusNode1, focusNode2, null),
                        _buildTextField(codeController2, focusNode2, focusNode3,
                            focusNode1),
                        _buildTextField(codeController3, focusNode3, focusNode4,
                            focusNode2),
                        _buildTextField(
                            codeController4, focusNode4, null, focusNode3),
                      ],
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
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 450,
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton(
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
                ),
              ),
              // 인증번호 입력 버튼
              Positioned(
                left: 0,
                right: 0,
                top: 500,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 288,
                    height: 60,
                    child: CustomButton(
                      text: '인증하기',
                      onPressed: _verifyCode,
                    ),
                  ),
                ),
              ),
            ],
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
