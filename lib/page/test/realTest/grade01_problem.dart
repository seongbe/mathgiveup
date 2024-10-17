import 'dart:math';
import 'package:flutter/material.dart';

class Grade01Problem {
  List<String> arithmeticAnswers = []; // 문제의 답을 저장할 리스트
  List<String> multiplyDivide = ['*', '/']; // 곱셈 나눗셈
  List<String> addSubtract = ['+', '-']; // 덧셈 뺄셈

  // 난수 생성
  int getRandomValue(int min, int max) {
    return Random().nextInt(max - min + 1) + min;
  }

  // 수와 연산
  // 랜덤한 산술 연산 문제 생성
  String generateArithmeticExpressionProblem() {
    int a = getRandomValue(1, 9); // 1부터 9까지
    int b = getRandomValue(1, 9);
    int c = getRandomValue(1, 9);
    int d = getRandomValue(2, 4); // 2부터 4까지 (지수)
    String firstOperator =
        multiplyDivide[Random().nextInt(multiplyDivide.length)];
    String secondOperator = addSubtract[Random().nextInt(addSubtract.length)];
    String thirdOperator = addSubtract[Random().nextInt(addSubtract.length)];

    if (firstOperator == '/' && secondOperator == '-' && b == c) {
      while (b == c) {
        c = getRandomValue(1, 9);
      }
    }

    // d² 계산
    int dSquared = d * d;

    // 첫 번째 사칙연산 계산
    double secondOperationResult;
    if (secondOperator == '+') {
      secondOperationResult = b + c.toDouble();
    } else {
      secondOperationResult = b - c.toDouble();
    }

    // 두 번째 사칙연산 계산
    double firstOperationResult;
    if (firstOperator == '*') {
      firstOperationResult = a * secondOperationResult;
    } else {
      firstOperationResult = a / secondOperationResult;
    }

    // 세 번째 사칙연산 계산
    double answer;
    if (thirdOperator == '+') {
      answer = firstOperationResult + dSquared;
    } else {
      answer = firstOperationResult - dSquared;
    }

    String problem =
        '다음 식을 계산하세요: $a $firstOperator ($b $secondOperator $c) $thirdOperator $d²';
    print('$problem: $answer');
    arithmeticAnswers.add(answer.toStringAsFixed(2));
    return problem;
  }

  // 일차 방정식 문제 생성
  String generateLinearEquationProblem() {
    int x = getRandomValue(-10, 9); // -10부터 9까지
    int a = getRandomValue(1, 9); // 계수 1부터 9까지
    int b = getRandomValue(-10, 9); // 상수항 -10부터 9까지
    int c;
    String operator = addSubtract[Random().nextInt(addSubtract.length)];
    if (operator == '+') {
      c = a * x + b;
    } else {
      c = a * x - b;
    }
    String axTerm = a == 1 ? 'x' : '${a}x';
    String problem = '방정식 $axTerm $operator $b = $c 의 해를 구하세요.';
    print('$problem: x = $x');
    arithmeticAnswers.add(x.toString());
    return problem;
  }

  // 최대공약수 문제 생성
  String generateGCDProblem() {
    int a = getRandomValue(1, 50); // 1부터 50까지
    int b = getRandomValue(1, 50);
    String problem = '$a와 $b의 최대공약수와 최소공배수를 구하세요.';

    int originalA = a, originalB = b; // 원래 값 저장
    // GCD 계산
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }

    //LCM 계산
    int lcm = (originalA * originalB) ~/ a;

    arithmeticAnswers.add(a.toString()); // 최대공약수 저장
    arithmeticAnswers.add(lcm.toString()); // 최소공배수 저장
    print('$problem: 최대공약수 = $a, 최소공배수 = $lcm');
    return problem;
  }

  // 문자와 식
  // 문자식 단순화 문제 생성
  String generateSimplifyExpressionProblem() {
    int k = getRandomValue(1, 9);
    int l = getRandomValue(1, 9);
    int m = getRandomValue(1, 9);
    String firstoper = addSubtract[Random().nextInt(addSubtract.length)];
    String secondoper = addSubtract[Random().nextInt(addSubtract.length)];

    int result;
    // 첫 번째 연산자 계산
    if (firstoper == '+') {
      result = k + l;
    } else {
      result = k - l;
    }
    // 두 번째 연산자 계산
    if (secondoper == '+') {
      result = result + m;
    } else {
      result = result - m;
    }

    String problem = '식을 단순화하세요: ${k}a $firstoper ${l}a $secondoper ${m}a';
    print('$problem: ${result}a');
    arithmeticAnswers.add(result.toString());
    return problem;
  }

  // 식 전개 문제 생성
  String generateExpandExpressionProblem() {
    int a = getRandomValue(1, 9);
    int b = getRandomValue(1, 9);
    String firstoper = addSubtract[Random().nextInt(addSubtract.length)];
    String secondoper = addSubtract[Random().nextInt(addSubtract.length)];

    // 일차항 계산
    int c;
    if (firstoper == secondoper) {
      if (firstoper == '+') {
        c = a + b;
      } else {
        c = -a - b;
      }
    } else {
      if (firstoper == '+') {
        c = a - b;
      } else {
        c = -a + b;
      }
    }

    // 상수항 계산
    int d = (firstoper == '+' ? a : -a) * (secondoper == '+' ? b : -b);

    // 부호 추가 및 결과식 구성
    String cxTerm = c > 0 ? '+ ${c}x' : '- ${-c}x';
    String dTerm = d > 0 ? '+ $d' : '- ${-d}';

    String result = 'x^2 $cxTerm $dTerm';
    String problem = '다음 식을 전개하세요: (x $firstoper $a)(x $secondoper $b)';
    print('$problem: $result');
    arithmeticAnswers.add(result);
    return problem;
  }

  // 식 인수분해 문제 생성
  String generateFactorExpressionProblem() {
    int p = getRandomValue(1, 9);
    int q = getRandomValue(1, 9);
    int b = p + q;
    int c = p * q;
    String problem = '다음 식을 인수분해하세요: x² + ${b}x + $c';
    String factoredForm = '(x + $p)(x + $q)';

    print('$problem: $factoredForm');
    arithmeticAnswers.add(factoredForm); // 정답 저장

    return problem;
  }

  //좌표평면과 그래프
  // 두 점 사이의 거리 문제 생성
  String generateDistanceBetweenPointsProblem() {
    int x1 = getRandomValue(-10, 10);
    int y1 = getRandomValue(-10, 10);
    int x2 = getRandomValue(-10, 10);
    int y2 = getRandomValue(-10, 10);

    // 두 점 사이의 거리 계산
    double distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));

    String problem = '두 점 ($x1, $y1), ($x2, $y2) 사이의 거리를 구하세요.';
    print('$problem: $distance');
    arithmeticAnswers.add(distance.toStringAsFixed(2));
    return problem;
  }

  // 두 점을 지나는 직선의 기울기 문제 생성
  String generateSlopeBetweenPointsProblem() {
    int x1 = getRandomValue(-10, 10);
    int y1 = getRandomValue(-10, 10);
    int x2;
    do {
      x2 = getRandomValue(-10, 10);
    } while (x1 == x2); // x1과 x2가 같지 않도록
    int y2 = getRandomValue(-10, 10);

    // 기울기 계산
    double slope = (y2 - y1) / (x2 - x1);

    String problem = '점 ($x1, $y1), ($x2, $y2)을 지나는 직선의 기울기를 구하세요.';
    print('$problem: $slope');
    arithmeticAnswers.add(slope.toStringAsFixed(2));
    return problem;
  }

  //기하
  // 삼각형의 넓이 문제 생성
  String generateTriangleAreaProblem() {
    int base = getRandomValue(1, 20);
    int height = getRandomValue(1, 20);
    double area = 0.5 * base * height;

    String problem = '밑변의 길이가 $base cm이고 높이가 $height cm인 삼각형의 넓이를 구하세요.';
    arithmeticAnswers.add(area.toStringAsFixed(2));
    print('$problem: $area');
    return problem;
  }

// 원의 둘레 문제 생성
  String generateCircleCircumferenceProblem() {
    int radius = getRandomValue(1, 20);
    double circumference = 2 * pi * radius;

    String problem = '반지름이 $radius cm인 원의 둘레를 구하세요.';
    arithmeticAnswers.add(circumference.toStringAsFixed(2));
    print('$problem: $circumference');
    return problem;
  }

// 직육면체의 부피 문제 생성
  String generateRectangularPrismVolumeProblem() {
    int length = getRandomValue(1, 20);
    int width = getRandomValue(1, 20);
    int height = getRandomValue(1, 20);
    int volume = length * width * height;

    String problem =
        '가로 $length cm, 세로 $width cm, 높이 $height cm인 직육면체의 부피를 구하세요.';
    arithmeticAnswers.add(volume.toString());
    print('$problem: $volume');
    return problem;
  }
}
