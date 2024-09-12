import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Test UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String player1Id = "player1";
  String player2Id = "player2";
  int player1Score = 0;
  int player2Score = 0;
  String result = "";

  // 플레이어 선택 전송
  Future<void> sendSelection(String playerId, bool isCorrect) async {
    final url = Uri.parse('http://43.200.7.186:8080/select');
    try {
      print(
          "Sending selection for $playerId. Correct: $isCorrect"); // 디버그 메시지 추가
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'playerId': playerId,
          'correct': isCorrect,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Response data: $data"); // 응답 데이터 디버깅
        setState(() {
          if (playerId == player1Id) {
            player1Score = data['currentScore'];
          } else {
            player2Score = data['currentScore'];
          }
        });
      } else {
        print(
            "Failed to send selection. Status code: ${response.statusCode}"); // 상태 코드 확인
      }
    } catch (e) {
      print("Error sending selection: $e"); // 예외 디버깅
    }
  }

  // 최종 결과 불러오기
  Future<void> getFinalResult() async {
    final url = Uri.parse(
        'http://43.200.7.186:8080/final-result?player1Id=$player1Id&player2Id=$player2Id');
    try {
      print(
          "Fetching final result for $player1Id and $player2Id"); // 디버그 메시지 추가
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Final result data: $data"); // 응답 데이터 디버깅
        setState(() {
          result = "Winner: ${data['winnerId']}, Score: ${data['winnerScore']}";
        });
      } else {
        print(
            "Failed to fetch final result. Status code: ${response.statusCode}"); // 상태 코드 확인
        setState(() {
          result = "Failed to fetch result";
        });
      }
    } catch (e) {
      print("Error fetching final result: $e"); // 예외 디버깅
      setState(() {
        result = "Error fetching final result";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Test UI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Player 1 Score: $player1Score",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "Player 2 Score: $player2Score",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () =>
                  sendSelection(player1Id, true), // player1 correct 선택
              child: Text("Player 1 Correct Answer"),
            ),
            ElevatedButton(
              onPressed: () =>
                  sendSelection(player1Id, false), // player1 wrong 선택
              child: Text("Player 1 Wrong Answer"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  sendSelection(player2Id, true), // player2 correct 선택
              child: Text("Player 2 Correct Answer"),
            ),
            ElevatedButton(
              onPressed: () =>
                  sendSelection(player2Id, false), // player2 wrong 선택
              child: Text("Player 2 Wrong Answer"),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: getFinalResult,
              child: Text("Get Final Result"),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
