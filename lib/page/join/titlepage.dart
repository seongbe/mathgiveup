import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/router/homepage.dart';
import 'package:mathgame/page/join/loginPage.dart';

class Titlepage extends StatelessWidget {
  const Titlepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lottie.asset(
          //   'assets/titlePage.json',
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
          Image.asset(
            'assets/titlePage.gif',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 200),
                Text(
                  'Smath',
                  textAlign: TextAlign.center,
                  style: skyboriBaseTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 60,
                    height: 0.01,
                  ),
                ),
                SizedBox(height: 450),
                Container(
                  height: 60,
                  child: CustomButton(
                    text: '시작하기',
                    onPressed: () {
                      Get.to(Homepage());
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  child: CustomButton(
                    text: '로그인',
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
