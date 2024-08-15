import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/game/GamePage1.dart';

class GameSelectPage extends StatelessWidget {
  const GameSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
                Get.toNamed('/game2');
              },
              child: Text('1대1게임'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/game3');
              },
              child: Text('수학피하기 게임'),
            ),
            // 원하는 만큼 게임을 추가하세요.
          ],
        ),
      );

  }
}