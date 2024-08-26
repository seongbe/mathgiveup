import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:mathgame/page/test/%08testResultPage.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/test/grade1_process02.dart'; // 새로 분리된 메소드 파일

class Grade1_02 extends StatelessWidget {
  Grade1_02({super.key});

  final Grade1Process02 grade1Process = Grade1Process02(); // 메소드 클래스 생성

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
        child: MyWidget(grade1Process: grade1Process),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final Grade1Process02 grade1Process;

  MyWidget({required this.grade1Process, super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    widget.grade1Process.generateNewProblemSet(); // 새로운 문제 생성
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            '다음 식을 간단히 하시오.',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < 2; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label: '${i + 1}. ${widget.grade1Process.expressions[i]}',
                controller: widget.grade1Process.expressionControllers[i],
                hintText: '답을 입력하세요',
                errorMessage: '',
              ),
            ),
          Divider(thickness: 2),
          SizedBox(height: 20),
          Text(
            'X의 값을 구하시오.',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < 2; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomInputField(
                label: '${i + 3}. ${widget.grade1Process.equations[i]}',
                controller: widget.grade1Process.equationControllers[i],
                hintText: '정답을 입력하세요',
                errorMessage: '',
              ),
            ),
          Divider(thickness: 2),
          SizedBox(height: 20),
          Text(
            widget.grade1Process.algebraProblemStatement,
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          for (int i = 0; i < 2; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${i + 5}.',
                      style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Math.tex(
                          widget.grade1Process.algebraEquations[i],
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: List.generate(4, (index) {
                    return RadioListTile<int>(
                      title: Text(widget.grade1Process.algebraOptions[i][index]
                          .toString()), // 정수 출력
                      value: widget.grade1Process.algebraOptions[i][index],
                      groupValue: widget.grade1Process.selectedOptions[i],
                      onChanged: (value) {
                        setState(() {
                          widget.grade1Process.selectedOptions[i] = value;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
          SizedBox(height: 20),
          CustomButton(
            text: '제출',
            fontSize: 20,
            onPressed: () => widget.grade1Process.checkAllAnswers(context),
          ),
        ],
      ),
    );
  }
}
