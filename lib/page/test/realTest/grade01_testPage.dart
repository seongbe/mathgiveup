import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/test/realTest/grade01_problem.dart';

class Grade01Testpage extends StatelessWidget {
  final Grade01Problem problem01 = Grade01Problem();
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
        child: MyWidget(problem01: problem01),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final Grade01Problem problem01;

  MyWidget({required this.problem01});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final List<TextEditingController> resultControllers =
      List.generate(15, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '1. ${widget.problem01.generateArithmeticExpressionProblem()}',
                controller: resultControllers[0],
                hintText: '정답을 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            CustomInputField(
                label: '2. ${widget.problem01.generateLinearEquationProblem()}',
                controller: resultControllers[1],
                hintText: 'x의 값을 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            CustomInputField(
                label: '3. ${widget.problem01.generateGCDProblem()}',
                controller: resultControllers[2],
                hintText: '최대공약수를 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 7),
            CustomTextField(
                controller: resultControllers[3], hintText: '최소공배수를 입력하세요.'),
            SizedBox(height: 20),
            Divider(thickness: 2),
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '4. ${widget.problem01.generateSimplifyExpressionProblem()}',
                controller: resultControllers[4],
                hintText: '단순화한 식을 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '5. ${widget.problem01.generateExpandExpressionProblem()}',
                controller: resultControllers[5],
                hintText: 'aX^2 + bx + c 형식으로 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '6. ${widget.problem01.generateFactorExpressionProblem()}',
                controller: resultControllers[6],
                hintText: '(ax + b)(cx + d) 형식으로 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            Divider(thickness: 2),
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '7. ${widget.problem01.generateDistanceBetweenPointsProblem()}',
                controller: resultControllers[7],
                hintText: '두 점 사이의 거리를 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '8. ${widget.problem01.generateSlopeBetweenPointsProblem()}',
                controller: resultControllers[8],
                hintText: '두 점을 지나는 직선의 기울기를 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            Divider(thickness: 2),
            SizedBox(height: 20),
            CustomInputField(
                label: '9. ${widget.problem01.generateTriangleAreaProblem()}',
                controller: resultControllers[9],
                hintText: '삼각형의 넓이를 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '10. ${widget.problem01.generateCircleCircumferenceProblem()}',
                controller: resultControllers[10],
                hintText: '원의 둘레를 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
            CustomInputField(
                label:
                    '11. ${widget.problem01.generateRectangularPrismVolumeProblem()}',
                controller: resultControllers[11],
                hintText: '직육면체의 부피를 입력하세요.',
                errorMessage: ''),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
