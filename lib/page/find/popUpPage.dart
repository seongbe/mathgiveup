import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/certificationPage02.dart';

class PopUpPage extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  PopUpPage({this.message = '', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: ListView(
          children: [
            MyWidget(
              message: message,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  MyWidget({required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 360,
        height: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0), // 텍스트 주변에 여백 추가
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // 배경색을 흰색으로 설정
                borderRadius:
                    BorderRadius.circular(10.0), // 모서리를 둥글게 설정 (선택 사항)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도 설정
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // 그림자의 위치 조정
                  ),
                ],
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: skyboriBaseTextStyle.copyWith(fontSize: 27),
              ),
            ),
            SizedBox(height: 50), // 위젯 사이의 간격
            Container(
              width: 100,
              height: 50,
              child: CustomButton(
                text: '확 인',
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
