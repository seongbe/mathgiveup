import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart'; // Import the colors.dart file for color constants

// 앱바
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: skyboriBaseTextStyle.copyWith(
          fontSize: 30,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// 배경화면
class BackgroundContainer extends StatelessWidget {
  final Widget child;

  BackgroundContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

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

// 버튼에 들어갈 텍스트 스타일
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
  final bool enabled;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.enabled = true, // 기본값은 활성화로 설정
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
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
// 보통 버튼 크기
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? fontSize;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
        minimumSize: Size(width ?? 100.0, height ?? 50.0),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: skyboriButtonTextStyle.copyWith(fontSize: fontSize ?? 30),
      ),
    );
  }
}

// 큰 버튼 크기
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
        minimumSize: Size(width ?? 100.0, height ?? 50.0),
      ),
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: skyboriButtonTextStyle.copyWith(fontSize: 35),
          ),
          SizedBox(
            height: 40,
          ),
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
//오답노트 테이블
