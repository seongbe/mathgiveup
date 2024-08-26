import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/game/GamePage1.dart';
import 'package:mathgame/game/GamePage2.dart';
import 'package:mathgame/game/GamePage3.dart';
import 'package:mathgame/game/GamePage4.dart';
import 'package:mathgame/game/GamePage5.dart';

class GameSelectPage extends StatelessWidget {
  const GameSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      
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
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                   Get.to(() => GamePage());
                  },
                  child: Text('문제 맞추기 게임'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => GamePage2());
                  },
                  child: Text('1대1게임'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                   Get.to(() => GamePage3());
                  },
                  child: Text('수학스테이지 게임'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                   Get.to(() => GamePage4());
                  },
                  child: Text('수학피하기 게임'),
                ),
                 SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                   Get.to(() => Gamepage5());
                  },
                  child: Text('미로게임'),
                ),
               
              ],
            ),
          ),
      ],
    );

  }
}