import 'package:flutter/material.dart';
import 'package:mathgame/game/Stage/cloudGame/cloudGameApp.dart';
import 'package:mathgame/game/Stage/cloudGame/cloudGameApp02.dart';
import 'package:mathgame/game/Stage/stage04.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathgame/const/colors.dart'; // BACKGROUND_COLOR를 위한 임포트
import 'package:mathgame/const/styles.dart'; // 커스텀 스타일을 위한 임포트
import 'package:mathgame/game/Stage/stage01.dart';
import 'package:mathgame/game/Stage/stage02.dart';

class StageSelectionPage extends StatefulWidget {
  @override
  _StageSelectionPageState createState() => _StageSelectionPageState();
}

class _StageSelectionPageState extends State<StageSelectionPage> {
  int currentStage = 12; // 기본값으로 1을 사용

  @override
  void initState() {
    super.initState();
    _loadCurrentStage(); // 앱 실행 시 현재 스테이지 로드
  }

  // 이거 나중에 API로 바꾸기!!
  void _loadCurrentStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentStage = prefs.getInt('currentStage') ?? 6; // 저장된 값이 없으면 1로 초기화
    });
  }

  void _updateCurrentStage(int newStage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (newStage > currentStage) {
        currentStage = newStage;
        prefs.setInt('currentStage', currentStage); // 업데이트된 스테이지 저장
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.alphaBlend(
          Colors.white.withOpacity(0.1),
          BACKGROUND_COLOR,
        ),
        appBar: CustomAppBar(title: '스테이지 선택'),
        body: StageSelectionScreen(
          currentStage: currentStage,
          onStageCompleted: _updateCurrentStage,
        ),
      ),
    );
  }
}

class StageSelectionScreen extends StatefulWidget {
  final int currentStage;
  final void Function(int) onStageCompleted;

  StageSelectionScreen(
      {required this.currentStage, required this.onStageCompleted});

  @override
  _StageSelectionScreenState createState() => _StageSelectionScreenState();
}

class _StageSelectionScreenState extends State<StageSelectionScreen> {
  final int totalStages = 10; // 총 스테이지 수
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentStage();
    });
  }

  void _scrollToCurrentStage() {
    double itemHeight = 100.0; // 각 스테이지 버튼의 높이 (padding 포함)
    double topPosition =
        (totalStages - widget.currentStage) * itemHeight; // 현재 스테이지 위치
    double screenHeight = MediaQuery.of(context).size.height;
    double offset = topPosition - (screenHeight / 2) + (itemHeight / 2);
    _scrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: totalStages * 103.0,
        child: Stack(
          children: List.generate(totalStages, (index) {
            int stageNumber = totalStages - index; // 낮은 숫자가 아래로 가도록 반전
            double topPosition = index * 100.0; // top 위치를 100씩 증가

            return Positioned(
              left: stageNumber % 2 == 1 ? 50 : 250,
              top: topPosition,
              child: _buildStageButton(context, stageNumber),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStageButton(BuildContext context, int stageNumber) {
    String buttonImage;
    double buttonSize = stageNumber == widget.currentStage ? 100 : 80;

    if (stageNumber < widget.currentStage) {
      buttonImage = 'assets/images/cloud.png';
    } else if (stageNumber == widget.currentStage) {
      buttonImage = 'assets/images/cloud3.png';
    } else {
      buttonImage = 'assets/images/cloud2.png';
    }

    return GestureDetector(
      onTap: stageNumber <= widget.currentStage
          ? () => _navigateToStage(context, stageNumber)
          : null,
      child: Column(
        children: [
          Image.asset(
            buttonImage,
            width: buttonSize,
            height: buttonSize,
          ),
          SizedBox(height: 8),
          Text(
            '스테이지 $stageNumber',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToStage(BuildContext context, int stageNumber) {
    Widget targetPage;

    switch (stageNumber) {
      case 1:
        targetPage = CloudGameApp(
          onStageCompleted: () {
            widget.onStageCompleted(stageNumber + 1); // 다음 스테이지 열림
            Navigator.pop(context); // 현재 스테이지 종료 후 돌아옴
          },
        );
        break;
      case 2:
        targetPage = Stage02(
          onStageCompleted: () {
            widget.onStageCompleted(stageNumber + 1); // 다음 스테이지 열림
            Navigator.pop(context); // 현재 스테이지 종료 후 돌아옴
          },
        );
        break;
      case 3:
        targetPage = CloudGameApp02(
          onStageCompleted: () {
            widget.onStageCompleted(stageNumber + 1); // 다음 스테이지 열림
            Navigator.pop(context); // 현재 스테이지 종료 후 돌아옴
          },
        );
        break;
      case 4:
        targetPage = Stage04(
          onStageCompleted: () {
            widget.onStageCompleted(stageNumber + 1); // 다음 스테이지 열림
            Navigator.pop(context); // 현재 스테이지 종료 후 돌아옴
          },
        );
        break;
      default:
        targetPage = Scaffold(
          appBar: AppBar(
            title: Text('스테이지 $stageNumber'),
          ),
          body: Center(
            child: Text('스테이지 $stageNumber 선택됨'),
          ),
        );
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}
