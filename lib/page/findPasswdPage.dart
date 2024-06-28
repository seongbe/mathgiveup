import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';

class FindPasswdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 재설정', style: TextStyle(fontFamily: 'Skybori')),
      ),
      body: Center(
        child: Text(
          '비밀번호 재설정 UI 구현',
          style: TextStyle(fontSize: 24, fontFamily: 'Skybori'),
        ),
      ),
    );
  }
}
