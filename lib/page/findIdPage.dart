import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';

class FindIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('아이디 찾기', style: TextStyle(fontFamily: 'Skybori')),
      ),
      body: Center(
        child: Text(
          '아이디 찾기 UI 구현',
          style: TextStyle(fontSize: 24, fontFamily: 'Skybori'),
        ),
      ),
    );
  }
}
