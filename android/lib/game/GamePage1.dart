import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    setState(() {
      _questions = [
        "2 + 2",
        "5 * 3",
        "sqrt(16)",
        "10 / 2",
        "9 - 3",
      ];
    });

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
          title: Text(
            'Game Over',
            style: TextStyle(fontSize: 28, color: Colors.redAccent),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your final score is:', style: TextStyle(fontSize: 18)),
              Text(
                '$_score',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('Restart', style: TextStyle(fontSize: 18)),
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Game Page'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _questions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LinearProgressIndicator(
                        value: (_currentQuestionIndex + 1) / _questions.length,
                        backgroundColor: Colors.white,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Question ${_currentQuestionIndex + 1}:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _questions[_currentQuestionIndex],
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _controller,
                        onChanged: (value) {
                          _userAnswer = value;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: '정답을 입력하세요',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.black54,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          '정답제출',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _userAnswer ==
                                  (_answers.isNotEmpty
                                      ? _answers[_currentQuestionIndex]
                                      : '')
                              ? Colors.green
                              : Colors.lightBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Score: $_score',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
