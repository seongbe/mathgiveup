import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamePage3 extends StatefulWidget {
  const GamePage3({super.key});

  @override
  State<GamePage3> createState() => _GamePage3State();
}

class _GamePage3State extends State<GamePage3> {
  int stage = 1; // 초기 스테이지
  int playerScore = 0;
  String question = '';
  int answer = 0;
  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    Random random = Random();
    int num1 = random.nextInt(10 * stage) + 1;
    int num2 = random.nextInt(10 * stage) + 1;
    int operation = stage > 10 ? random.nextInt(4) : random.nextInt(3); // 0: +, 1: -, 2: *, 3: /

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
      case 3:
        if (num2 != 0 && num1 % num2 == 0) {
          question = '$num1 / $num2';
          answer = num1 ~/ num2;
        } else {
          generateQuestion(); // 나누기가 불가능하면 다른 문제 생성
          return;
        }
        break;
    }

    setState(() {});
  }

  void checkAnswer() {
    if (int.tryParse(answerController.text) == answer) {
      playerScore += 10 * stage; // 스테이지마다 더 많은 점수를 획득
      if (stage < 50) {
        stage++;
        generateQuestion();
      } else {
        Get.defaultDialog(
          title: 'Congratulations!',
          middleText: 'You have completed all stages!',
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
            resetGame();
          },
        );
      }
    } else {
      Get.snackbar('Incorrect', 'Try again!', snackPosition: SnackPosition.BOTTOM);
    }

    answerController.clear();
    setState(() {});
  }

  void resetGame() {
    stage = 1;
    playerScore = 0;
    generateQuestion();
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
        title: Text('Game Page - Stage $stage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $playerScore',
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
                labelText: 'Your Answer',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkAnswer,
              child: Text('Submit'),
            ),
            SizedBox(height: 40),
            stage < 50
                ? Text('Stage $stage of 50', style: TextStyle(fontSize: 20))
                : Text('Final Stage', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
