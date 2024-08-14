import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/test/mathProblem.dart';

class TestCode02 extends StatelessWidget {
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
  MathProblemGenerator1 generator1 = MathProblemGenerator1();
  MathProblemGenerator2 generator2 = MathProblemGenerator2();
  MathProblemGenerator3 generator3 = MathProblemGenerator3();
  String _problem = '';

  void _generateProblem(int grade) {
    setState(() {
      if (grade == 1) {
        _problem = generator1.generateRandomProblem();
      } else if (grade == 2) {
        _problem = generator2.generateRandomProblem();
      } else if (grade == 3) {
        _problem = generator3.generateRandomProblem();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_problem.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _problem,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _generateProblem(1),
            child: Text('Generate Grade 1 Problem'),
          ),
          ElevatedButton(
            onPressed: () => _generateProblem(2),
            child: Text('Generate Grade 2 Problem'),
          ),
          ElevatedButton(
            onPressed: () => _generateProblem(3),
            child: Text('Generate Grade 3 Problem'),
          ),
        ],
      ),
    );
  }
}
