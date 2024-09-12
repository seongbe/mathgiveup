import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';

class Stage1 extends StatelessWidget {
  final VoidCallback? onStageCompleted;

  Stage1({this.onStageCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '스테이지 1'),
      body: BackgroundContainer(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            StageGamePage01(onStageCompleted: onStageCompleted),
          ],
        ),
      ),
    );
  }
}

class StageGamePage01 extends StatefulWidget {
  final VoidCallback? onStageCompleted;

  StageGamePage01({this.onStageCompleted});

  @override
  _StageGamePageState01 createState() => _StageGamePageState01();
}

class _StageGamePageState01 extends State<StageGamePage01> {
  int level = 1;
  int score = 0;
  int number = 0;
  int currentInput = 0;
  List<int> factors = [];
  String message = "숫자를 입력하세요";

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startNewLevel();
  }

  void _startNewLevel() {
    setState(() {
      number = _generateNumberForLevel(level);
      factors = _getPrimeFactors(number);
      message = "숫자를 입력하세요";
      _controller.clear();
    });
  }

  int _generateNumberForLevel(int level) {
    Random rand = Random();
    int base = rand.nextInt(5) + 2; // 2에서 6까지의 임의의 소수를 선택
    int multiplier = rand.nextInt(level) + 2; // 레벨에 따라 증가하는 난이도
    return pow(base, multiplier).toInt(); // 예: 2^3, 3^4 등
  }

  List<int> _getPrimeFactors(int number) {
    List<int> factors = [];
    for (int i = 2; i <= number / i; i++) {
      while (number % i == 0) {
        factors.add(i);
        number ~/= i;
      }
    }
    if (number > 1) {
      factors.add(number);
    }
    return factors;
  }

  void _checkInput() {
    int input = int.tryParse(_controller.text) ?? 0;

    if (factors.contains(input)) {
      setState(() {
        number ~/= input;
        factors.remove(input);
        message = "$input 는 올바른 소수입니다!";
        if (number == 1) {
          level++;
          score += level * 10;
          message = "레벨 $level 완료! 새로운 숫자로 이동합니다.";
          _startNewLevel();
          if (widget.onStageCompleted != null) {
            widget.onStageCompleted!(); // 스테이지 완료 콜백 호출
          }
        }
      });
    } else {
      setState(() {
        message = "$input 는 잘못된 소수입니다. 다시 시도하세요.";
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '레벨: $level',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            '숫자: $number',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: '소수를 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _checkInput,
            child: Text('확인'),
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            '점수: $score',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
