import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/mypage/learningInfo/gameBarChar.dart';
import 'package:mathgame/page/mypage/learningInfo/gameInfo.dart';

class LearningStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '학습 통계'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          LearningStatisticsContent(),
        ],
      ),
    );
  }
}

class LearningStatisticsContent extends StatefulWidget {
  @override
  _LearningStatisticsContentState createState() =>
      _LearningStatisticsContentState();
}

class _LearningStatisticsContentState extends State<LearningStatisticsContent> {
  String? gameInfo;

  void _handleBarTouch(int index) {
    setState(() {
      gameInfo = getGameInfo(index); // 선택된 인덱스에 따라 게임 정보를 가져옴
    });
  }

  // int 리스트를 double 리스트로 변환하는 함수
  List<double> _convertToDoubleList(List<int> intList) {
    return intList.map((value) => value.toDouble()).toList();
  }

  Widget _buildGameSection(String title, List<int> data) {
    return Column(
      children: [
        Text(title, style: skyboriBaseTextStyle.copyWith(fontSize: 25)),
        SizedBox(height: 20),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16.0),
            child: createGameBarChart(
              _convertToDoubleList(data),
              onBarTouch: _handleBarTouch,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGameSection('스테이지 게임', [5, 2, 10, 4, 6, 15, 12]),
        _buildGameSection('퀴즈 게임', [5, 2, 10, 4, 6, 15, 12]),
        _buildGameSection('1:1 게임', [5, 2, 10, 4, 6, 15, 12]),
        if (gameInfo != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              gameInfo!,
              style: skyboriBaseTextStyle,
            ),
          ),
      ],
    );
  }
}
