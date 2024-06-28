import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입', style: TextStyle(fontFamily: 'Skybori')),
      ),
      body: Center(
        child: Text(
          '회원가입',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
