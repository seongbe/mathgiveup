import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';

class TestCode extends StatelessWidget {
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
  final TextEditingController _controller = TextEditingController();
  String _question = '';
  String _result = '';
  bool _isLoading = false;

  // WolframAlpha API 키
  final String apiKey = 'LWYX87-LR62EH3Y59';

  // 산술 문제 생성
  void _generateQuestion() {
    final random = Random();
    int num1 = random.nextInt(100);
    int num2 = random.nextInt(100);
    _question = '$num1 + $num2';
  }

  // WolframAlpha API 호출
  Future<void> _fetchData(String query) async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    String url =
        'http://api.wolframalpha.com/v2/query?input=${Uri.encodeComponent(query)}&appid=$apiKey&output=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String result = _parseWolframAlphaResponse(data);
        setState(() {
          _result = result;
          _isLoading = false;
        });
      } else {
        setState(() {
          _result = 'Request failed with status: ${response.statusCode}.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  // WolframAlpha API 응답 파싱
  String _parseWolframAlphaResponse(Map<String, dynamic> data) {
    if (data['queryresult']['success']) {
      List pods = data['queryresult']['pods'];
      for (var pod in pods) {
        if (pod['title'] == 'Result') {
          return pod['subpods'][0]['plaintext'];
        }
      }
    }
    return 'No result found';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Enter your question',
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              _fetchData(_controller.text);
            }
          },
          child: Text('Get Answer'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _generateQuestion();
            _fetchData(_question);
          },
          child: Text('Generate Question'),
        ),
        SizedBox(height: 20),
        Text(
          'Generated Question: $_question',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        _isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: SingleChildScrollView(
                  child: Text(_result),
                ),
              ),
      ],
    );
  }
}
