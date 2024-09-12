import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/game/Stage/stageSelectionPage.dart';
import 'package:mathgame/page/test/grade1_process01.dart'; // 올바른 경로로 수정 필요

class Stage2 extends StatelessWidget {
  final VoidCallback? onStageCompleted;

  Stage2({this.onStageCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.alphaBlend(
          Colors.white.withOpacity(0.1),
          BACKGROUND_COLOR,
        ),
        appBar: CustomAppBar(title: '스테이지 2'),
        body: NumberPuzzleScreen(onStageCompleted: onStageCompleted),
      ),
    );
  }
}

class NumberPuzzleScreen extends StatefulWidget {
  final VoidCallback? onStageCompleted;

  NumberPuzzleScreen({this.onStageCompleted});

  @override
  _NumberPuzzleScreenState createState() => _NumberPuzzleScreenState();
}

class _NumberPuzzleScreenState extends State<NumberPuzzleScreen> {
  late final Grade1Process01 grade1Process01 = Grade1Process01();
  final Random _random = Random();
  int _targetNumber = 0;
  List<int> _factors = [];
  List<int> _puzzleTiles = [];
  List<int> _selectedTiles = [];
  bool _isGameOver = false;
  int _score = 0;
  int _rounds = 0;
  final int _totalRounds = 5;

  @override
  void initState() {
    super.initState();
    _generateNewPuzzle();
  }

  void _generateNewPuzzle() {
    setState(() {
      _targetNumber = _random.nextInt(99) + 2; // 2부터 100까지의 랜덤 숫자
      _factors = grade1Process01.primeFactors(_targetNumber);

      // 소인수 타일을 2개 이상으로 유지하되, _targetNumber보다 작은 값만 추가
      List<int> selectedFactors = List<int>.from(_factors)
          .where((factor) => factor < _targetNumber)
          .toList();
      if (selectedFactors.length < 2) {
        selectedFactors.add(_random.nextInt(_targetNumber - 1) + 1);
      }

      // 소인수가 아닌 타일 생성, _targetNumber보다 작은 값만 추가
      List<int> nonFactors = [];
      while (nonFactors.length < 3) {
        int randomTile = _random.nextInt(_targetNumber - 1) + 1;
        if (!selectedFactors.contains(randomTile) &&
            !nonFactors.contains(randomTile)) {
          nonFactors.add(randomTile);
        }
      }

      // 퍼즐 타일 리스트 구성
      List<int> allTiles = selectedFactors + nonFactors;
      allTiles.shuffle();

      // 타일 수를 4~6개로 제한
      int numTiles = _random.nextInt(3) + 4; // 4부터 6까지의 랜덤 숫자
      _puzzleTiles = allTiles.take(numTiles).toList();
      _puzzleTiles.shuffle();

      // 게임 오버 상태 초기화
      _isGameOver = false;
      _selectedTiles.clear(); // 선택된 타일 초기화
    });
  }

  void _handleTileTap(int tile) {
    if (!_isGameOver && !_selectedTiles.contains(tile)) {
      setState(() {
        _selectedTiles.add(tile);
      });
    }
  }

  void _checkResults() {
    if (_isGameOver) return;

    setState(() {
      bool allSelectedAreNonFactors =
          _selectedTiles.every((tile) => !_factors.contains(tile));
      if (allSelectedAreNonFactors) {
        _score++;
        _showGameOverDialog('축하합니다! 선택한 모든 타일은 소인수가 아닙니다.');
      } else {
        _showGameOverDialog('게임 오버! 선택한 타일 중 일부는 소인수입니다.');
      }
    });
  }

  void _showGameOverDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (_isGameOver) return;

              setState(() {
                _isGameOver = true;
              });

              if (_rounds < _totalRounds - 1) {
                _rounds++;
                _generateNewPuzzle();
              } else if (_score >= 4) {
                if (widget.onStageCompleted != null) {
                  widget.onStageCompleted!(); // 스테이지 완료 콜백 호출
                }
                _showStageClearDialog();
              } else {
                _showFinalScoreDialog();
              }
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showStageClearDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('스테이지 클리어!'),
        content: Text('축하합니다! 스테이지를 클리어했습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StageSelectionPage()),
              );
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showFinalScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('게임 종료'),
        content: Text('최종 점수: $_score / $_totalRounds'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 게임 리셋
              setState(() {
                _score = 0;
                _rounds = 0;
                _generateNewPuzzle();
              });
            },
            child: Text('다시 시작'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center 위젯을 사용하여 전체 콘텐츠를 수평 및 수직으로 가운데 정렬
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // 수평 가운데 정렬
          children: [
            Text(
              '$_targetNumber의 소인수가 아닌 타일을 선택하세요',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center, // 텍스트 가운데 정렬
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center, // Wrap 내 아이템 수평 정렬
              children: _puzzleTiles.map((tile) {
                return GestureDetector(
                  onTap: () {
                    if (!_isGameOver) {
                      _handleTileTap(tile);
                    }
                  },
                  child: Container(
                    color: _selectedTiles.contains(tile)
                        ? Colors.green
                        : Colors.blue,
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      '$tile',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isGameOver ? null : _checkResults,
              child: Text('제출'),
            ),
            SizedBox(height: 20),
            Text(
              '현재 점수: $_score',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center, // 텍스트 가운데 정렬
            ),
          ],
        ),
      ),
    );
  }
}
