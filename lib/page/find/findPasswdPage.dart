import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                top: 200,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '비밀번호를 재설정할 \n SMath 아이디를 입력해주세요',
                    textAlign: TextAlign.center,
                    style: skyboriBaseTextStyle.copyWith(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 300,
                child: SizedBox(
                  width: 312.84,
                  child: CustomTextField(
                    controller: idController,
                    hintText: '아이디를 입력하세요.',
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 500,
                child: Container(
                  width: 288,
                  height: 60,
                  child: CustomButton(
                    text: '확인',
                    onPressed: _verifyId,
                  ),
                ),
              ),
              // 오류메세지
              if (errorMessage.isNotEmpty)
                Positioned(
                  left: 34,
                  top: 570,
                  right: 34,
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // 아이디 확인
  void _verifyId() {
    setState(() {
      if (idController.text.isEmpty) {
        errorMessage = '아이디를 입력하세요.';
      } else if (idController.text == 'qwer') {
        errorMessage = ''; // 오류메시지 초기화
        Get.to(CertificationPage01(title: '비밀번호 재설정'));
      } else {
        errorMessage = '';
        Get.to(FindPasswdFailPage());
      }
    });
  }
}
