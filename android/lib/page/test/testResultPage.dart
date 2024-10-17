import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/userInfo/userPreferences.dart';
import 'package:mathgame/router/homepage.dart';

class TestResultPage extends StatelessWidget {
  TestResultPage({super.key});

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
  MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<Map<String, dynamic>> _getScoresAndNickname() async {
    double? score01 = await UserPreferences.getScore01();
    double? score02 = await UserPreferences.getScore02();
    double? score03 = await UserPreferences.getScore03();
    double? score04 = await UserPreferences.getScore04();
    String? nickname = await UserPreferences.getNickname();

    // null 값이 있으면 0으로 대체
    List<double> scores = [
      score01 ?? 0.0,
      score02 ?? 0.0,
      score03 ?? 60.0,
      score04 ?? 60.0,
    ];

    return {
      "scores": scores,
      "nickname": nickname,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getScoresAndNickname(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading scores'));
        } else if (!snapshot.hasData || snapshot.data!['scores'].isEmpty) {
          return Center(child: Text('No scores available'));
        } else {
          List<double> scores = snapshot.data!['scores'];
          String nickname =
              snapshot.data!['nickname'] ?? '사용자'; // Default value
          List<String> categories = ["수와 연산", "문자와 식", "함수", "도형"];

          // 가장 낮은 점수를 가진 단원들 찾기
          double minScore = scores.reduce((a, b) => a < b ? a : b);
          List<String> weakestSubjects = categories
              .asMap()
              .entries
              .where((entry) => scores[entry.key] == minScore)
              .map((entry) => entry.value)
              .toList();
          String weakestSubjectsText = weakestSubjects.join(', ');

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: categories.length + 2, // 추가된 문구와 버튼을 위해 +2
            itemBuilder: (context, index) {
              if (index < categories.length) {
                return _buildScoreCard(
                    context, categories[index], scores[index], index);
              } else if (index == categories.length) {
                return _buildWeaknessMessage(
                    context, nickname, weakestSubjectsText);
              } else {
                return _buildCompleteButton(context);
              }
            },
          );
        }
      },
    );
  }

  Widget _buildScoreCard(
      BuildContext context, String category, double score, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                score.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 20,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceEvenly,
                        maxY: 100,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(show: false),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: score,
                                color: PRIMARY_COLOR,
                                width: 20,
                                borderRadius: BorderRadius.circular(5),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 100,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeaknessMessage(
      BuildContext context, String nickname, String weakestSubjectsText) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0), // 메시지를 더 아래로 내리기 위한 padding
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '$nickname님은 $weakestSubjectsText이(가) 취약한 편입니다.',
          textAlign: TextAlign.center,
          style: skyboriBaseTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0), // 버튼을 메시지 아래에 배치
      child: Center(
        child: CustomButton(
          text: '테스트 완료',
          fontSize: 25,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          },
        ),
      ),
    );
  }
}
