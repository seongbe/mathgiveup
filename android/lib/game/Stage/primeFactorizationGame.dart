import 'package:flutter/material.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrimeFactorizationGame(),
    );
  }
}

class PrimeFactorizationGame extends StatefulWidget {
  @override
  _PrimeFactorizationGameState createState() => _PrimeFactorizationGameState();
}

class _PrimeFactorizationGameState extends State<PrimeFactorizationGame> {
  List<int> numbers = [];
  List<List<int>> correctFactorsList = [];
  String resultMessage = "";

  @override
  void initState() {
    super.initState();
    generatePrimeFactorizationProblems();
  }

  void generatePrimeFactorizationProblems() {
    Random random = Random();
    numbers =
        List.generate(2, (_) => random.nextInt(100) + 1); // 1~100 사이의 숫자 2개 생성
    correctFactorsList =
        numbers.map((n) => primeFactors(n)).toList(); // 각 숫자에 대한 소인수분해 결과 생성
  }

  List<int> primeFactors(int n) {
    List<int> factors = [];
    int divisor = 2;
    while (n > 1) {
      while (n % divisor == 0) {
        factors.add(divisor);
        n ~/= divisor;
      }
      divisor++;
    }
    return factors;
  }

  void checkAnswer(int selectedIndex) {
    int count1 = correctFactorsList[0].length;
    int count2 = correctFactorsList[1].length;

    if (selectedIndex == 2) {
      // "같음" 버튼 클릭
      if (count1 == count2) {
        setState(() {
          resultMessage = "정답입니다! 두 숫자는 같은 인수 개수를 가지고 있습니다.";
        });
      } else {
        setState(() {
          resultMessage = "오답입니다! 두 숫자는 다른 인수 개수를 가지고 있습니다.";
        });
      }
    } else {
      if ((count1 > count2 && selectedIndex == 0) ||
          (count2 > count1 && selectedIndex == 1)) {
        setState(() {
          resultMessage = "정답입니다!";
        });
      } else {
        setState(() {
          resultMessage = "오답입니다!";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('소인수분해 게임'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '어떤 숫자가 더 많은 인수를 가지고 있을까요?',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => checkAnswer(0),
              child: Text(numbers[0].toString()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => checkAnswer(1),
              child: Text(numbers[1].toString()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => checkAnswer(2),
              child: Text('같음'),
            ),
            SizedBox(height: 20),
            Text(
              resultMessage,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
