import 'dart:math';

class MathProblem {
  final String problem;
  final double answer;

  MathProblem(this.problem, this.answer);
}

// 1학년
class MathProblemGenerator1 {
  Random random = Random();

  int randomNunmber() {
    return random.nextInt(200);
  }

  // 자연수, 정수, 유리수의 사칙연산 문제 생성
  String generateBasicArithmeticProblem() {
    int a = random.nextInt(100);
    int b = random.nextInt(100);
    List<String> operators = ['+', '-', '*', '/'];
    String operator = operators[random.nextInt(operators.length)];

    if (operator == '/') {
      // Division should not have a remainder
      b = (b == 0) ? 1 : b; // avoid division by zero
      a = b * (1 + random.nextInt(10)); // ensure a is a multiple of b
    }

    return '$a $operator $b의 값을 입력하시오.';
  }

  // 소인수분해 함수
  List<int> primeFactors(int n) {
    List<int> factors = [];
    // 2로 나누어 떨어지는 경우 처리
    while (n % 2 == 0) {
      factors.add(2);
      n ~/= 2;
    }
    // 3 이상의 홀수로 나누어 떨어지는 경우 처리
    for (int i = 3; i <= n ~/ i; i += 2) {
      while (n % i == 0) {
        factors.add(i);
        n ~/= i;
      }
    }
    // 남은 소수 처리
    if (n > 2) {
      factors.add(n);
    }
    return factors;
  }

  void generatePrimeFactorizationProblem() {
    int number = random.nextInt(100);
    List<int> factors = primeFactors(number);

    print('정답: ${factors.join(' × ')}');
  }

  // 일차 방정식 문제 생성
  String generateLinearEquationProblem() {
    int a = random.nextInt(10) + 1; // avoid zero
    int b = random.nextInt(20) - 10;
    int c = a * (random.nextInt(20) - 10);
    return '$a * x + $b = $c일 때 x의 값은?';
  }

  // 함수의 개념과 그래프 문제 생성
  String generateFunctionProblem() {
    int a = random.nextInt(10) + 1;
    int b = random.nextInt(20) - 10;
    int x = random.nextInt(10);
    int y = a * x + b;
    return 'For function y = $a * x + $b, find y when x = $x.';
  }

  // 기하학 문제 생성
  String generateGeometryProblem() {
    int side = random.nextInt(20) + 1;
    return 'Find the perimeter of a square with side length $side cm.';
  }

  // 자료 정리 문제 생성
  String generateStatisticsProblem() {
    List<int> data = List.generate(5, (_) => random.nextInt(20));
    return 'Find the mean of the following data: ${data.join(', ')}.';
  }

  // 랜덤 문제 생성
  String generateRandomProblem() {
    List<String Function()> problemGenerators = [
      generateBasicArithmeticProblem,
      generateLinearEquationProblem,
      generateFunctionProblem,
      generateGeometryProblem,
      generateStatisticsProblem,
    ];
    return problemGenerators[random.nextInt(problemGenerators.length)]();
  }
}

// 2학년
class MathProblemGenerator2 {
  Random random = Random();

  // 유한소수, 무한소수, 순환소수 문제 생성
  String generateDecimalProblem() {
    double a = (random.nextInt(100) + 1) / 10;
    double b = (random.nextInt(100) + 1) / 10;
    return '$a + $b = ?';
  }

  // 이차방정식 문제 생성
  String generateQuadraticEquationProblem() {
    int a = random.nextInt(5) + 1;
    int b = random.nextInt(10) - 5;
    int c = random.nextInt(10) - 5;
    return '$a * x^2 + $b * x + $c = 0일 떄 x = ?';
  }

  // 일차부등식 문제 생성
  String generateLinearInequalityProblem() {
    int a = random.nextInt(10) + 1;
    int b = random.nextInt(20) - 10;
    int c = random.nextInt(20) - 10;
    return '$a * x + $b <= $c. x <= ?';
  }

  // 닮음과 피타고라스 정리 문제 생성
  String generatePythagorasProblem() {
    int a = random.nextInt(10) + 1;
    int b = random.nextInt(10) + 1;
    return 'Find the hypotenuse of a right triangle with legs $a cm and $b cm.';
  }

  // 경우의 수와 확률 문제 생성
  String generateProbabilityProblem() {
    int a = random.nextInt(10) + 1;
    int b = random.nextInt(10) + 1;
    return 'What is the probability of drawing a $a out of $b cards?';
  }

  // 랜덤 문제 생성
  String generateRandomProblem() {
    List<String Function()> problemGenerators = [
      generateDecimalProblem,
      generateQuadraticEquationProblem,
      generateLinearInequalityProblem,
      generatePythagorasProblem,
      generateProbabilityProblem,
    ];
    return problemGenerators[random.nextInt(problemGenerators.length)]();
  }
}

// 3학년
class MathProblemGenerator3 {
  Random random = Random();

  // 제곱근과 실수 문제 생성
  String generateSquareRootProblem() {
    int a = random.nextInt(100);
    return 'Find the square root of $a.';
  }

  // 이차방정식 문제 생성
  String generateQuadraticEquationProblem() {
    int a = random.nextInt(5) + 1;
    int b = random.nextInt(10) - 5;
    int c = random.nextInt(10) - 5;
    return '$a * x^2 + $b * x + $c = 0. x = ?';
  }

  // 이차함수 문제 생성
  String generateQuadraticFunctionProblem() {
    int a = random.nextInt(10) - 5;
    int b = random.nextInt(10) - 5;
    int c = random.nextInt(10) - 5;
    int x = random.nextInt(10) - 5;
    return 'For function y = $a * x^2 + $b * x + $c, find y when x = $x.';
  }

  // 삼각비와 원 문제 생성
  String generateTrigonometryProblem() {
    int a = random.nextInt(10) + 1;
    return 'Find the sine of a 30 degree angle in a right triangle where the opposite side is $a cm.';
  }

  // 통계 문제 생성
  String generateStatisticsProblem() {
    List<int> data = List.generate(5, (_) => random.nextInt(20));
    return 'Find the mean of the following data: ${data.join(', ')}.';
  }

  // 랜덤 문제 생성
  String generateRandomProblem() {
    List<String Function()> problemGenerators = [
      generateSquareRootProblem,
      generateQuadraticEquationProblem,
      generateQuadraticFunctionProblem,
      generateTrigonometryProblem,
      generateStatisticsProblem,
    ];
    return problemGenerators[random.nextInt(problemGenerators.length)]();
  }
}
