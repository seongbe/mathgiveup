import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mathgame/page/test/testResultPage.dart';
import 'package:mathgame/userInfo/userPreferences.dart';

class Grade1Process02 {
  // 컨트롤러 생성
  final List<TextEditingController> expressionControllers =
      List.generate(2, (index) => TextEditingController()); // 식 간단히 문제 컨트롤러
  final List<TextEditingController> equationControllers =
      List.generate(2, (index) => TextEditingController()); // 방정식 문제 컨트롤러

  List<String> expressions = []; // 문제로 제시할 식 리스트
  List<String> simplifiedExpressions = []; // 간단히 한 결과 리스트
  List<String> equations = []; // 방정식 문제 리스트
  List<int> correctAnswers = []; // 방정식 문제 정답 리스트 (문제 생성 시 계산됨)

  // 알지브라 문제와 관련된 변수
  List<int?> selectedOptions = List.filled(2, null); // 2개의 알지브라 문제
  String algebraProblemStatement = ''; // 한 번만 생성
  List<String> algebraEquations = [];
  List<List<int>> algebraOptions = [];
  List<int> algebraCorrectAnswers = [];
  Map<String, int> algebraVariables = {};

  void generateNewProblemSet() {
    generateExpressions(); // 문자가 포함된 식 생성
    generateEquations(); // 방정식 문제 생성
    generateAlgebraProblem(); // 알지브라 문제 생성
  }

  // 문자가 포함된 식을 생성하는 함수
  void generateExpressions() {
    Random random = Random();
    expressions.clear();
    simplifiedExpressions.clear();

    for (int i = 0; i < 2; i++) {
      int coefficient1 = random.nextInt(10) + 1;
      int coefficient2 = random.nextInt(10) + 1;
      String variable = String.fromCharCode(random.nextInt(5) + 97); // 랜덤 문자 생성

      bool isAddition = random.nextBool(); // 무작위로 덧셈 또는 뺄셈 선택

      String expression = isAddition
          ? "$coefficient1$variable + $coefficient2$variable"
          : "$coefficient1$variable - $coefficient2$variable";
      expressions.add(expression);

      int resultCoefficient = isAddition
          ? coefficient1 + coefficient2
          : coefficient1 - coefficient2;
      simplifiedExpressions.add("$resultCoefficient$variable");
    }
  }

  // 방정식 문제를 2개 생성하는 함수
  void generateEquations() {
    Random random = Random();
    equations.clear();
    correctAnswers.clear();

    for (int i = 0; i < 2; i++) {
      int a = random.nextInt(10) + 1;
      int b = random.nextInt(11);
      int x = random.nextInt(10) + 1;
      int result = a * x + b;

      if (a == 1) {
        equations.add("x + $b = $result");
      } else if (b == 0) {
        equations.add("${a}x = $result");
      } else {
        equations.add("${a}x + $b = $result");
      }
      correctAnswers.add(x);
    }
  }

  // 알지브라 문제를 2개 생성하는 함수
  void generateAlgebraProblem() {
    Random random = Random();
    algebraEquations.clear();
    algebraOptions.clear();
    algebraCorrectAnswers.clear();
    algebraVariables.clear();

    algebraVariables = {
      'x': random.nextInt(10) + 1,
      'y': random.nextInt(10) + 1,
    };

    for (int j = 0; j < 2; j++) {
      int coefficientAx = random.nextInt(7) - 3;
      int coefficientAy = random.nextInt(7) - 3;
      int coefficientBx = random.nextInt(7) - 3;
      int coefficientBy = random.nextInt(7) - 3;

      int A = coefficientAy * algebraVariables['y']!;
      int B = coefficientBx * algebraVariables['x']! +
          coefficientBy * algebraVariables['y']!;

      int coefficientA = random.nextInt(7) - 3;
      int coefficientB = random.nextInt(7) - 3;
      int correctAnswer = coefficientA * A + coefficientB * B;
      algebraCorrectAnswers.add(correctAnswer);

      String equation = r'A = ' +
          (coefficientAy != 0 ? coefficientAy.toString() + 'y' : '') +
          r',\ B = ' +
          (coefficientBx != 0 ? coefficientBx.toString() + 'x ' : '') +
          (coefficientBy != 0 ? ' + ' + coefficientBy.toString() + 'y' : '') +
          r'\text{ 일 때 } ' +
          (coefficientA != 0 ? coefficientA.toString() + r'A ' : '') +
          (coefficientB != 0
              ? (coefficientB < 0 ? ' - ' : ' + ') +
                  coefficientB.abs().toString() +
                  r'B '
              : '') +
          r'를 구하시오.';
      algebraEquations.add(equation);

      List<int> options =
          List.generate(4, (index) => correctAnswer + random.nextInt(21) - 10);
      options[random.nextInt(4)] = correctAnswer;
      algebraOptions.add(options);
    }

    algebraProblemStatement =
        '다음 식을 x=${algebraVariables['x']}, y=${algebraVariables['y']}일 때의 값을 구하시오.';
  }

  // 모든 문제의 정답을 확인하고 점수와 정답 비율을 저장하는 함수
  Future<void> checkAllAnswers(BuildContext context) async {
    int score = 0;
    int totalQuestions = expressionControllers.length +
        equationControllers.length +
        algebraEquations.length; // 총 6문제 (2 + 2 + 2)

    for (int i = 0; i < 2; i++) {
      if (expressionControllers[i].text.trim() == simplifiedExpressions[i]) {
        score++;
      }
    }

    for (int i = 0; i < 2; i++) {
      int userAnswer = int.tryParse(equationControllers[i].text.trim()) ?? 0;
      if (userAnswer == correctAnswers[i]) {
        score++;
      }
    }

    for (int i = 0; i < 2; i++) {
      if (selectedOptions[i] == algebraCorrectAnswers[i]) {
        score++;
      }
    }

    double accuracy = (score / totalQuestions) * 100;
    await UserPreferences.saveScore02(accuracy);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TestResultPage()),
    );
  }
}
