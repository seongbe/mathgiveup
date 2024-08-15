import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _questions = [];
  List<String> _answers = [];
  int _currentQuestionIndex = 0;
  String _userAnswer = '';
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    // 여기에 고정된 문제 리스트를 추가하거나, API를 통해 문제를 불러올 수 있습니다.
    setState(() {
      _questions = [
        "2 + 2",
        "5 * 3",
        "sqrt(16)",
        "10 / 2",
        "9 - 3",
      ];
    });

    // API를 통해 각 문제의 답을 불러옵니다.
    for (String question in _questions) {
      await _solveMathProblem(question);
    }
  }

  Future<void> _solveMathProblem(String query) async {
    const String appId = 'GPJXQX-8G6QYXPH5P'; // 여기에 받은 App ID를 넣으세요.
    final String url =
        'http://api.wolframalpha.com/v2/query?input=$query&appid=$appId&output=json';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _answers.add(data['queryresult']['pods'][1]['subpods'][0]['plaintext']);
        });
      } else {
        setState(() {
          _answers.add('Error');
        });
      }
    } catch (e) {
      setState(() {
        _answers.add('Error');
      });
    }
  }

  void _checkAnswer() {
    if (_userAnswer == _answers[_currentQuestionIndex]) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _userAnswer = '';
        _controller.clear();
      });
    } else {
      _showFinalScore();
    }
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your final score is: $_score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _userAnswer = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: _questions.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text('Question ${_currentQuestionIndex + 1}:'),
                  Text(
                    _questions[_currentQuestionIndex],
                    style: const TextStyle(fontSize: 24),
                  ),
                  TextField(
                    controller: _controller,
                    onChanged: (value) {
                      _userAnswer = value;
                    },
                    decoration: const InputDecoration(
                      hintText: '정답을 입력하세요',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _checkAnswer,
                    child: const Text('정답제출'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Score: $_score',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
      ),
    );
  }
}
