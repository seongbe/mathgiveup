import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/test/grade1_process01.dart';

class Grade1_01 extends StatelessWidget {
  final Grade1Process01 grade1Process01 = Grade1Process01();

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
        child: MyWidget(grade1Process01: grade1Process01),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final Grade1Process01 grade1Process01;

  MyWidget({required this.grade1Process01});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    widget.grade1Process01.generatePrimeFactorizationProblems();
    widget.grade1Process01.generateRandomNumbers();
    widget.grade1Process01.generateArithmeticProblems();
    widget.grade1Process01.generateComparisonProblems();
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
          for (int i = 0;
              i < widget.grade1Process01.factorControllers.length;
              i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label: '${i + 1}. ${widget.grade1Process01.numbers[i]}',
                controller: widget.grade1Process01.factorControllers[i],
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
          for (int i = 0; i < widget.grade1Process01.gcdControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 3}. ${widget.grade1Process01.number1[i]}, ${widget.grade1Process01.number2[i]}',
                    style: skyboriBaseTextStyle.copyWith(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    label: '최대공약수 (GCD)',
                    controller: widget.grade1Process01.gcdControllers[i],
                    hintText: 'GCD를 입력하세요',
                    errorMessage: '',
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    label: '최소공배수 (LCM)',
                    controller: widget.grade1Process01.lcmControllers[i],
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
          for (int i = 0;
              i < widget.grade1Process01.arithmeticControllers.length;
              i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label:
                    '${i + 5}. ${widget.grade1Process01.arithmeticProblems[i]}',
                controller: widget.grade1Process01.arithmeticControllers[i],
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
          for (int i = 0;
              i < widget.grade1Process01.comparisonControllers.length;
              i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label:
                    '${i + 7}. ${widget.grade1Process01.comparisonProblems[i]}',
                controller: widget.grade1Process01.comparisonControllers[i],
                hintText: '정답을 입력하세요 (>, <, =)',
                errorMessage: '',
              ),
            ),
          SizedBox(height: 20),
          CustomButton(
            text: '다음',
            fontSize: 20,
            onPressed: () => widget.grade1Process01.checkAnswers(context),
          ),
        ],
      ),
    );
  }
}
