import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mathgame/component/button.dart';
import 'package:mathgame/page/homepage.dart';
import 'package:mathgame/page/loginPage.dart';

class Titlepage extends StatelessWidget {
  const Titlepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Lottie.asset(
              'assets/tiltePage.json',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'SMath',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Get.to(Homepage());
                    },
                    child: Text(
                      '시작하기',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 93, 97, 213),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 680,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 93, 97, 213),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
