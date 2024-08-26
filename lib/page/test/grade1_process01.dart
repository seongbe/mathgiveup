import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mathgame/page/test/garde1_02.dart';
import 'package:mathgame/userInfo/userPreferences.dart';

class Grade1Process01 {
  final List<TextEditingController> factorControllers =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> gcdControllers =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> lcmControllers =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> arithmeticControllers =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> comparisonControllers =
      List.generate(2, (index) => TextEditingController());

  List<int> numbers = [];
  List<List<int>> correctFactorsList = [];
  late List<int> number1 = [];
  late List<int> number2 = [];
  List<String> arithmeticProblems = [];
  List<num> arithmeticAnswers = [];
  List<String> comparisonProblems = [];
  List<String> comparisonAnswers = [];

  void generatePrimeFactorizationProblems() {
    Random random = Random();
    numbers =
        List.generate(2, (_) => random.nextInt(100) + 1); // 1~100 사이의 숫자 2개 생성
    correctFactorsList =
        numbers.map((n) => primeFactors(n)).toList(); // 각 숫자에 대한 소인수분해 결과 생성
    factorControllers
        .forEach((controller) => controller.clear()); // 모든 입력 필드 초기화
  }

  void generateRandomNumbers() {
    Random random = Random();
    number1 = List.generate(
        2, (_) => random.nextInt(100) + 1); // 1~100 사이의 첫 번째 숫자 리스트 생성
    number2 = List.generate(
        2, (_) => random.nextInt(100) + 1); // 1~100 사이의 두 번째 숫자 리스트 생성
    gcdControllers
        .forEach((controller) => controller.clear()); // 모든 GCD 입력 필드 초기화
    lcmControllers
        .forEach((controller) => controller.clear()); // 모든 LCM 입력 필드 초기화
  }

  void generateArithmeticProblems() {
    Random random = Random();
    List<String> operators = ['+', '-', '*', '/'];

    arithmeticProblems = List.generate(2, (_) {
      int a = random.nextInt(100) - 50; // -50부터 49까지의 정수
      int b = random.nextInt(100) - 50; // -50부터 49까지의 정수
      String operator = operators[random.nextInt(operators.length)];
      double answer = 0;

      if (operator == '/') {
        b = (b == 0) ? 1 : b; // 0으로 나누지 않도록 처리
        answer = a / b;
      } else if (operator == '+') {
        answer = a + b.toDouble();
      } else if (operator == '-') {
        answer = a - b.toDouble();
      } else if (operator == '*') {
        answer = a * b.toDouble();
      }

      arithmeticAnswers.add(answer);
      return '$a $operator $b'; // 정수로 출력
    });

    arithmeticControllers
        .forEach((controller) => controller.clear()); // 입력 필드 초기화
  }

  void generateComparisonProblems() {
    Random random = Random();
    comparisonProblems = List.generate(2, (_) {
      num a =
          random.nextInt(100) - 50 + random.nextDouble(); // -50부터 49.99까지의 유리수
      num b =
          random.nextInt(100) - 50 + random.nextDouble(); // -50부터 49.99까지의 유리수
      String correctAnswer;

      if (a > b) {
        correctAnswer = '>';
      } else if (a < b) {
        correctAnswer = '<';
      } else {
        correctAnswer = '=';
      }

      comparisonAnswers.add(correctAnswer);
      return '${a.toStringAsFixed(2)} ? ${b.toStringAsFixed(2)}'; // 문제 생성
    });

    comparisonControllers
        .forEach((controller) => controller.clear()); // 입력 필드 초기화
  }

  List<int> primeFactors(int n) {
    List<int> factors = [];
    while (n % 2 == 0) {
      factors.add(2);
      n ~/= 2;
    }
    for (int i = 3; i <= n ~/ i; i += 2) {
      while (n % i == 0) {
        factors.add(i);
        n ~/= i;
      }
    }
    if (n > 2) {
      factors.add(n);
    }
    return factors;
  }

  int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  int lcm(int a, int b) {
    return (a * b) ~/ gcd(a, b); // LCM은 GCD를 사용하여 계산
  }

  Future<void> checkAnswers(BuildContext context) async {
    int score = 0;
    int totalQuestions = factorControllers.length +
        gcdControllers.length +
        arithmeticControllers.length +
        comparisonControllers.length;

    // 소인수분해 문제 채점
    for (int i = 0; i < factorControllers.length; i++) {
      List<String> userFactors = factorControllers[i].text.split('*');
      List<int> userFactorsInt = userFactors
          .map((e) => int.tryParse(e.trim()))
          .where((e) => e != null)
          .map((e) => e!)
          .toList();

      userFactorsInt.sort();
      correctFactorsList[i].sort();

      if (userFactorsInt.toString() == correctFactorsList[i].toString()) {
        score++;
      }
    }

    // 최대공약수와 최소공배수 문제 채점
    for (int i = 0; i < 2; i++) {
      int userGcd = int.tryParse(gcdControllers[i].text.trim()) ?? -1;
      int userLcm = int.tryParse(lcmControllers[i].text.trim()) ?? -1;

      int correctGcd = gcd(number1[i], number2[i]);
      int correctLcm = lcm(number1[i], number2[i]);

      if (userGcd == correctGcd && userLcm == correctLcm) {
        score++;
      }
    }

    // 사칙연산 문제 채점
    for (int i = 0; i < arithmeticControllers.length; i++) {
      num userAnswer =
          num.tryParse(arithmeticControllers[i].text.trim()) ?? double.nan;

      if ((arithmeticAnswers[i] % 1 == 0 &&
              userAnswer == arithmeticAnswers[i].toInt()) ||
          (userAnswer == arithmeticAnswers[i])) {
        score++;
      }
    }

    // 대소관계 문제 채점
    for (int i = 0; i < comparisonControllers.length; i++) {
      String userAnswer = comparisonControllers[i].text.trim();

      if (userAnswer == comparisonAnswers[i]) {
        score++;
      }
    }

    // 정답 비율 계산
    double accuracy = (score / totalQuestions) * 100;

    // 정답 비율을 SharedPreferences에 저장
    await UserPreferences.saveScore01(accuracy);
    double? b = await UserPreferences.getScore01();
    print(b);

    // 다음 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Grade1_02()),
    );
  }
}
