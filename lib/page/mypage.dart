import 'package:flutter/material.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // 배경 이미지 설정
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'), // 배경 이미지 경로
              fit: BoxFit.cover, // 이미지 크기 조정 방식
            ),
          ),
        ),
        // 배경 이미지 위에 배치될 위젯들
        Column(
          children: [
            Text(
              '마이 페이지',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // 다른 위젯들도 여기에 추가
          ],
        ),
      ],
    );
  }
}