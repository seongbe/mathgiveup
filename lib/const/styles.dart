import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart'; // Import the colors.dart file for color constants

// 기본 텍스트 스타일
final TextStyle skyboriBaseTextStyle = TextStyle(
  fontFamily: 'Skybori',
  fontWeight: FontWeight.w400,
);

// 기본 텍스트 스타일에서 색상, 글씨 크기, 줄간격 설정
final TextStyle skyboriTextStyle = skyboriBaseTextStyle.copyWith(
  color: TEXT_COLOR,
  fontSize: 15,
  height: 0.06,
);

// 밑줄 추가
final TextStyle skyboriUnderlineTextStyle = skyboriTextStyle.copyWith(
  decoration: TextDecoration.underline,
);

// 이건 기본 텍스트 스타일에서 회색으로 설정
final TextStyle skyboriHintTextStyle = skyboriTextStyle.copyWith(
  color: HINT_TEXT_COLOR,
);

// 버튼에 들어갈 텍스트 스타일인데 큰 버튼, 작은 버튼으로 나눠야 하나
final TextStyle skyboriButtonTextStyle = skyboriBaseTextStyle.copyWith(
  color: Colors.white,
  fontSize: 30,
  height: 0.02,
  letterSpacing: -0.41,
);

// 입력 필드
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: skyboriHintTextStyle,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      obscureText: obscureText,
      style: skyboriTextStyle.copyWith(color: Colors.black),
    );
  }
}

// 버튼 스타일 설정
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
   

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,

     
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
        minimumSize: Size( width ?? 100.0, height ?? 50.0),
        
        
      ),
      
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: skyboriButtonTextStyle,
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String text;
  final String text2;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
   

  const CustomButton2({
    Key? key,
    required this.text,
    required this.text2,
    required this.onPressed,
    this.height,
    this.width,

     
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
        minimumSize: Size( width ?? 100.0, height ?? 50.0),
        
        
      ),
      
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: skyboriButtonTextStyle.copyWith(fontSize: 35),
          ),
          SizedBox(height: 40,),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: skyboriButtonTextStyle.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
