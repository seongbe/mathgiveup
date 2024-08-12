import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';

class Grade1_02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '실력테스트'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final List<TextEditingController> factorControllers =
      List.generate(3, (index) => TextEditingController());
  final List<TextEditingController> gcdControllers =
      List.generate(3, (index) => TextEditingController());
  final List<TextEditingController> lcmControllers =
      List.generate(3, (index) => TextEditingController());
  final List<TextEditingController> arithmeticControllers =
      List.generate(3, (index) => TextEditingController());
  final List<TextEditingController> comparisonControllers =
      List.generate(3, (index) => TextEditingController());

  List<int> numbers = [];
  List<List<int>> correctFactorsList = [];
  late List<int> number1 = [];
  late List<int> number2 = [];
  List<String> arithmeticProblems = [];
  List<num> arithmeticAnswers = [];
  List<String> comparisonProblems = [];
  List<String> comparisonAnswers = [];

  @override
  void initState() {
    super.initState();
    generatePrimeFactorizationProblems();
    generateRandomNumbers();
    generateArithmeticProblems();
    generateComparisonProblems();
  }

  // 소인수분해 함수
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

  void generatePrimeFactorizationProblems() {
    Random random = Random();
    numbers =
        List.generate(3, (_) => random.nextInt(100) + 1); // 1~100 사이의 숫자 3개 생성
    correctFactorsList =
        numbers.map((n) => primeFactors(n)).toList(); // 각 숫자에 대한 소인수분해 결과 생성
    factorControllers
        .forEach((controller) => controller.clear()); // 모든 입력 필드 초기화
  }

  void generateRandomNumbers() {
    Random random = Random();
    number1 = List.generate(
        3, (_) => random.nextInt(100) + 1); // 1~100 사이의 첫 번째 숫자 리스트 생성
    number2 = List.generate(
        3, (_) => random.nextInt(100) + 1); // 1~100 사이의 두 번째 숫자 리스트 생성
    gcdControllers
        .forEach((controller) => controller.clear()); // 모든 GCD 입력 필드 초기화
    lcmControllers
        .forEach((controller) => controller.clear()); // 모든 LCM 입력 필드 초기화
  }

  // 최대공약수(GCD) 계산 함수
  int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  // 최소공배수(LCM) 계산 함수
  int lcm(int a, int b) {
    return (a * b) ~/ gcd(a, b); // LCM은 GCD를 사용하여 계산
  }

  // 정수의 사칙연산 문제 생성
  void generateArithmeticProblems() {
    Random random = Random();
    List<String> operators = ['+', '-', '*', '/'];

    arithmeticProblems = List.generate(3, (_) {
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

  // 정수와 유리수의 대소관계 문제 생성
  void generateComparisonProblems() {
    Random random = Random();
    comparisonProblems = List.generate(3, (_) {
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

  void checkAnswers() {
    List<String> results = [];

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
        results.add('소인수분해 문제 ${i + 1}: 정답입니다!');
      } else {
        results.add(
            '소인수분해 문제 ${i + 1}: 틀렸습니다. 정답은 ${correctFactorsList[i].join(' * ')} 입니다.');
      }
    }

    // 최대공약수와 최소공배수 문제 채점
    for (int i = 0; i < 3; i++) {
      int userGcd = int.tryParse(gcdControllers[i].text.trim()) ?? -1;
      int userLcm = int.tryParse(lcmControllers[i].text.trim()) ?? -1;

      int correctGcd = gcd(number1[i], number2[i]);
      int correctLcm = lcm(number1[i], number2[i]);

      if (userGcd == correctGcd && userLcm == correctLcm) {
        results.add('GCD와 LCM 문제 ${i + 1}: 정답입니다!');
      } else {
        results.add(
            'GCD와 LCM 문제 ${i + 1}: 틀렸습니다. GCD: $correctGcd, LCM: $correctLcm 입니다.');
      }
    }

    // 사칙연산 문제 채점
    for (int i = 0; i < arithmeticControllers.length; i++) {
      num userAnswer =
          num.tryParse(arithmeticControllers[i].text.trim()) ?? double.nan;

      // 정수로 표현 가능한 경우 정수 비교, 그렇지 않으면 소수점 비교
      if ((arithmeticAnswers[i] % 1 == 0 &&
              userAnswer == arithmeticAnswers[i].toInt()) ||
          (userAnswer == arithmeticAnswers[i])) {
        results.add('사칙연산 문제 ${i + 1}: 정답입니다!');
      } else {
        results
            .add('사칙연산 문제 ${i + 1}: 틀렸습니다. 정답은 ${arithmeticAnswers[i]} 입니다.');
      }
    }

    // 대소관계 문제 채점
    for (int i = 0; i < comparisonControllers.length; i++) {
      String userAnswer = comparisonControllers[i].text.trim();

      if (userAnswer == comparisonAnswers[i]) {
        results.add('대소관계 문제 ${i + 1}: 정답입니다!');
      } else {
        results
            .add('대소관계 문제 ${i + 1}: 틀렸습니다. 정답은 ${comparisonAnswers[i]} 입니다.');
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('채점 결과'),
          content: SingleChildScrollView(
            child: ListBody(
              children: results.map((result) => Text(result)).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    setState(() {
      // 새로운 문제 생성
      generatePrimeFactorizationProblems();
      generateRandomNumbers();
      generateArithmeticProblems();
      generateComparisonProblems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            '다음 수들을 소인수분해 하시오.',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < factorControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label: '${i + 1}. ${numbers[i]}',
                controller: factorControllers[i],
                hintText: '정답을 입력하세요.(예: 2 * 3 * 5)',
                errorMessage: '',
              ),
            ),
          Divider(thickness: 2),
          SizedBox(height: 20),
          Text(
            '다음 두 숫자의 최대공약수와\n최소공배수를 구하시오.',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 4}. ${number1[i]}, ${number2[i]}',
                    style: skyboriBaseTextStyle.copyWith(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    label: '최대공약수 (GCD)',
                    controller: gcdControllers[i],
                    hintText: 'GCD를 입력하세요',
                    errorMessage: '',
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    label: '최소공배수 (LCM)',
                    controller: lcmControllers[i],
                    hintText: 'LCM을 입력하세요',
                    errorMessage: '',
                  ),
                ],
              ),
            ),
          Divider(thickness: 2),
          SizedBox(height: 20),
          Text(
            '다음 문제의 사칙연산을 계산하시오.',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < arithmeticControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label: '${i + 7}. ${arithmeticProblems[i]}',
                controller: arithmeticControllers[i],
                hintText: '정답을 입력하세요',
                errorMessage: '',
              ),
            ),
          Divider(thickness: 2),
          SizedBox(height: 20),
          Text(
            '다음 유리수들의 대소관계를 구하시오.',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < comparisonControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label: '${i + 10}. ${comparisonProblems[i]}',
                controller: comparisonControllers[i],
                hintText: '정답을 입력하세요 (>, <, =)',
                errorMessage: '',
              ),
            ),
          ElevatedButton(
            onPressed: checkAnswers,
            child: Text('제출'),
          ),
        ],
      ),
    );
  }
}
