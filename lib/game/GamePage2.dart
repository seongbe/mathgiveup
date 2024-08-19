import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamePage2 extends StatefulWidget {
  const GamePage2({super.key});

  @override
  State<GamePage2> createState() => _GamePage2State();
}

class _GamePage2State extends State<GamePage2> {
  int player1Score = 0;
  int player2Score = 0;
  String question = '';
  int answer = 0;
  int currentPlayer = 1; // 1: Player 1, 2: Player 2
  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    Random random = Random();
    int num1 = random.nextInt(10) + 1;
    int num2 = random.nextInt(10) + 1;
    int operation = random.nextInt(3); // 0: +, 1: -, 2: *

    switch (operation) {
      case 0:
        question = '$num1 + $num2';
        answer = num1 + num2;
        break;
      case 1:
        question = '$num1 - $num2';
        answer = num1 - num2;
        break;
      case 2:
        question = '$num1 * $num2';
        answer = num1 * num2;
        break;
    }

    setState(() {});
  }

  void checkAnswer() {
    if (int.tryParse(answerController.text) == answer) {
      if (currentPlayer == 1) {
        player1Score++;
      } else {
        player2Score++;
      }
      generateQuestion();
    }

    answerController.clear();
    currentPlayer = currentPlayer == 1 ? 2 : 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigator.pop 대신 Get.back을 사용하여 뒤로가기
          },
        ),
        title: Text('Game Page'),
      ),
      body: Stack(
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
              children: [
                Text(
                  'Player $currentPlayer\'s Turn',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  question,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: answerController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '답을 제출해주세요',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => checkAnswer(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: Text('제출하기'),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Player 1 Score',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '$player1Score',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Player 2 Score',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '$player2Score',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
