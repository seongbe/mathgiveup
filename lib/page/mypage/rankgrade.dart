import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';

class Rankgrade extends StatelessWidget {
  const Rankgrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '실력등급'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          MyWidget(),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Text('골드',
        style: TextStyle(
          color: Color(0xFFF0D806),
          fontSize: 30,
        ),),
         SizedBox(height: 10,),
         Image.asset('assets/images/goldmedal.png'),
          Text('10문제이상',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),),
           SizedBox(height: 20,),
           Text('실버',
        style: TextStyle(
          color: Color(0xFF8B8A8C),
          fontSize: 30,
        ),),
          SizedBox(height: 10,),
         Image.asset('assets/images/silver-medal 1.png'),
          Text('5문제이상',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),),
             SizedBox(height: 20,),
           Text('브론즈',
        style: TextStyle(
          color: Color(0xFFAA7C36),
          fontSize: 30,
        ),),
          SizedBox(height: 10,),
         Image.asset('assets/images/bronze-medal 1.png'),
          Text('3문제이상',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),),
        SizedBox(height: 30,),
        Text('당신의 등급은 골드입니다.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
        Text('골드',
        style: TextStyle(
          color: Color(0xFFF0D806),
          fontSize: 30,
        ),),
         SizedBox(height: 10,),
         Image.asset('assets/images/goldmedal.png'),
          
      ],
    );
  }
}