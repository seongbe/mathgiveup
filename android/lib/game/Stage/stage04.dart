import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mathgame/const/styles.dart';

class Stage04 extends StatelessWidget {
  final VoidCallback? onStageCompleted;

  Stage04({this.onStageCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '삼각형 합동 게임',
      home: Scaffold(
        appBar: CustomAppBar(title: '삼각형 합동 찾기'),
        body: BackgroundContainer(
          child: Column(
            children: [
              Text('주어진 삼각형과 합동인 삼각형을 그리세요!'),
              Expanded(
                child: StageGamePage04(onStageCompleted: onStageCompleted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StageGamePage04 extends StatefulWidget {
  final VoidCallback? onStageCompleted;

  StageGamePage04({this.onStageCompleted});
  @override
  _StageGamePageState04 createState() => _StageGamePageState04();
}

class _StageGamePageState04 extends State<StageGamePage04> {
  List<Offset> fixedTriangle = []; // 주어진 삼각형의 점
  List<Offset> userTriangle = []; // 사용자가 그린 삼각형의 점
  List<Offset> gridPoints = []; // 화면에 표시할 그리드 점들
  String congruenceType = ''; // 합동 조건 (SSS, SAS, ASA)
  bool isCongruent = false; // 사용자가 그린 삼각형이 합동인지 여부
  int score = 0;
  String resultMessage = ''; // 결과 메시지

  @override
  void initState() {
    super.initState();
    _generateGridPoints(); // 그리드 점 생성
    _generateFixedTriangle(); // 주어진 삼각형 생성
    congruenceType = _chooseCongruenceType(); // SSS, SAS, ASA 중 하나를 선택
  }

  void _generateGridPoints() {
    // 화면에 고정된 그리드 점(격자)을 생성
    for (double x = 50; x <= 300; x += 50) {
      for (double y = 50; y <= 300; y += 50) {
        gridPoints.add(Offset(x, y));
      }
    }
  }

  void _generateFixedTriangle() {
    // 주어진 삼각형의 세 점을 Offset으로 직접 생성
    fixedTriangle = [
      Offset(150.0, 100.0), // 점 A
      Offset(150.0, 300.0), // 점 B
      Offset(250.0, 200.0), // 점 C
    ];
  }

  String _chooseCongruenceType() {
    // SSS, SAS, ASA 중 하나를 랜덤하게 선택
    List<String> types = ['SSS', 'SAS', 'ASA'];
    return types[Random().nextInt(3)];
  }

  void _handleTap(Offset tappedPoint) {
    // 터치한 위치와 가까운 그리드 포인트를 찾아 선택
    for (var point in gridPoints) {
      if ((point - tappedPoint).distance < 20) {
        setState(() {
          if (userTriangle.length == 3) {
            userTriangle.clear(); // 이미 삼각형이 완성된 경우 초기화
          }
          userTriangle.add(point); // 선택한 그리드 점 추가
        });
        break;
      }
    }
  }

  void _handleSubmit() {
    // 제출 버튼을 눌렀을 때 합동 여부를 검사
    setState(() {
      if (userTriangle.length == 3) {
        isCongruent = _checkCongruence();
        if (isCongruent) {
          score += 10; // 합동이면 점수 추가
          resultMessage = '축하합니다! 삼각형이 합동입니다!';
        } else {
          resultMessage = '합동이 아닙니다. 다시 시도하세요.';
        }
      } else {
        resultMessage = '삼각형을 완성하세요.';
      }
    });
  }

  bool _checkCongruence() {
    // SSS, SAS, ASA 조건에 따라 합동 여부를 확인
    if (congruenceType == 'SSS') {
      return _checkSSS();
    } else if (congruenceType == 'SAS') {
      return _checkSAS();
    } else if (congruenceType == 'ASA') {
      return _checkASA();
    }
    return false;
  }

  bool _checkSSS() {
    // SSS: 세 변의 길이가 모두 같으면 합동
    double fixedA = (fixedTriangle[0] - fixedTriangle[1]).distance;
    double fixedB = (fixedTriangle[1] - fixedTriangle[2]).distance;
    double fixedC = (fixedTriangle[2] - fixedTriangle[0]).distance;

    double userA = (userTriangle[0] - userTriangle[1]).distance;
    double userB = (userTriangle[1] - userTriangle[2]).distance;
    double userC = (userTriangle[2] - userTriangle[0]).distance;

    // 고정된 삼각형과 사용자가 그린 삼각형의 변을 정렬
    List<double> fixedSides = [fixedA, fixedB, fixedC]..sort();
    List<double> userSides = [userA, userB, userC]..sort();

    print('고정된 삼각형 변: $fixedSides');
    print('사용자가 그린 삼각형 변: $userSides');

    // 정렬된 변 길이를 비교
    return (fixedSides[0] - userSides[0]).abs() < 1 &&
        (fixedSides[1] - userSides[1]).abs() < 1 &&
        (fixedSides[2] - userSides[2]).abs() < 1;
  }

  bool _checkSAS() {
    // 고정된 삼각형의 변 길이 계산
    double fixedSideA = (fixedTriangle[0] - fixedTriangle[1]).distance;
    double fixedSideB = (fixedTriangle[1] - fixedTriangle[2]).distance;
    double fixedSideC = (fixedTriangle[2] - fixedTriangle[0]).distance;

    // 사용자가 그린 삼각형의 변 길이 계산
    double userSideA = (userTriangle[0] - userTriangle[1]).distance;
    double userSideB = (userTriangle[1] - userTriangle[2]).distance;
    double userSideC = (userTriangle[2] - userTriangle[0]).distance;

    // 고정된 삼각형과 사용자가 그린 삼각형에서 가장 긴 변을 제외하고, 나머지 두 변을 확인
    List<double> fixedSides = [fixedSideA, fixedSideB, fixedSideC]..sort();
    List<double> userSides = [userSideA, userSideB, userSideC]..sort();

    // 두 삼각형의 비율 계산 (비율이 같아야 함)
    double ratio1 = fixedSides[0] / userSides[0];
    double ratio2 = fixedSides[1] / userSides[1];

    // 두 비율이 유사한지 확인 (허용 범위 내에서)
    if ((ratio1 - ratio2).abs() > 0.01) {
      return false; // 비율이 다르면 유사하지 않음
    }

    // 두 변 사이의 각도를 계산 (끼인각 비교)
    double fixedAngle = _calculateAngleBetweenTwoSides(
        fixedTriangle, fixedSides[0], fixedSides[1]);
    double userAngle = _calculateAngleBetweenTwoSides(
        userTriangle, userSides[0], userSides[1]);

    print('고정된 삼각형 변 비율: $ratio1, 각도: $fixedAngle');
    print('사용자가 그린 삼각형 변 비율: $ratio2, 각도: $userAngle');

    // 각도가 같으면 유사 삼각형
    return (fixedAngle - userAngle).abs() < 0.1; // 각도 차이 허용 범위
  }

  double _calculateAngleBetweenTwoSides(
      List<Offset> triangle, double sideA, double sideB) {
    // 삼각형의 세 점을 통해 두 변 사이의 각도를 계산하는 함수
    Offset pointA = triangle[0];
    Offset pointB = triangle[1];
    Offset pointC = triangle[2];

    // 벡터 계산
    Offset vectorAB = pointB - pointA;
    Offset vectorAC = pointC - pointA;

    // 벡터 내적 구하기
    double dotProduct = vectorAB.dx * vectorAC.dx + vectorAB.dy * vectorAC.dy;

    // 벡터의 크기 계산
    double magnitudeAB =
        sqrt(vectorAB.dx * vectorAB.dx + vectorAB.dy * vectorAB.dy);
    double magnitudeAC =
        sqrt(vectorAC.dx * vectorAC.dx + vectorAC.dy * vectorAC.dy);

    // 코사인 법칙으로 각도 계산
    double cosTheta = dotProduct / (magnitudeAB * magnitudeAC);

    // 각도를 도(degree)로 변환
    return acos(cosTheta) * 180 / pi;
  }

  bool _checkASA() {
    // ASA: 두 각과 그 사이의 변이 같으면 합동
    // 각과 변의 길이를 비교하는 로직 (추가 필요)
    return false; // 실제 구현 필요
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('조건: $congruenceType 합동을 만족하는 삼각형을 그리세요!'),
        Text('점수: $score'),
        if (resultMessage.isNotEmpty)
          Text(resultMessage,
              style: TextStyle(color: isCongruent ? Colors.green : Colors.red)),
        Expanded(
          child: GestureDetector(
            onTapDown: (details) {
              _handleTap(details.localPosition); // 사용자의 점 선택
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter:
                      TrianglePainter(gridPoints, fixedTriangle, userTriangle),
                );
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _handleSubmit,
          child: Text('제출'),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  List<Offset> gridPoints; // 화면에 표시할 그리드 점들
  List<Offset> fixedTriangle; // 고정된 삼각형 점들
  List<Offset> userTriangle; // 사용자가 그린 삼각형 점들

  TrianglePainter(this.gridPoints, this.fixedTriangle, this.userTriangle);

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final fixedPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;

    final userPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    // 그리드 포인트 그리기
    for (var point in gridPoints) {
      canvas.drawCircle(point, 4, gridPaint);
    }

    // 주어진 삼각형 그리기
    _drawTriangle(canvas, fixedTriangle, fixedPaint);

    // 사용자가 그린 삼각형 그리기
    if (userTriangle.length == 3) {
      _drawTriangle(canvas, userTriangle, userPaint);
    }
  }

  void _drawTriangle(Canvas canvas, List<Offset> triangle, Paint paint) {
    if (triangle.length == 3) {
      canvas.drawLine(triangle[0], triangle[1], paint);
      canvas.drawLine(triangle[1], triangle[2], paint);
      canvas.drawLine(triangle[2], triangle[0], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
