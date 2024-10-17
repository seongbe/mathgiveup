import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mathgame/const/styles.dart';

Widget createGameBarChart(List<double> gameCounts,
    {required Function(int) onBarTouch}) {
  int todayIndex = DateTime.now().weekday % 7;

  List<String> weekDays = ['월', '화', '수', '목', '금', '토', '일'];

  List<double> reorderedGameCounts = List.from(gameCounts);
  reorderedGameCounts = reorderedGameCounts.sublist(todayIndex) +
      reorderedGameCounts.sublist(0, todayIndex);

  List<String> reorderedWeekDays =
      weekDays.sublist(todayIndex) + weekDays.sublist(0, todayIndex);

  return Container(
    height: 200,
    child: BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barTouchData: BarTouchData(
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              return;
            }
            int touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            onBarTouch(touchedIndex); // 터치된 인덱스를 콜백으로 전달
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(reorderedWeekDays[value.toInt()],
                    style: skyboriBaseTextStyle);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Y축 값 숨김
          ),
          topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false)), // 상단 타이틀 숨김
          rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false)), // 오른쪽 타이틀 숨김
        ),
        gridData: FlGridData(show: false), // 그리드 라인 숨김
        borderData: FlBorderData(show: false), // 테두리 숨김
        barGroups: reorderedGameCounts.asMap().entries.map((entry) {
          int idx = entry.key;
          double count = entry.value;
          return BarChartGroupData(
            x: idx,
            barRods: [
              BarChartRodData(
                toY: count,
                color: Colors.blue,
                width: 20,
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 20,
                  color: Colors.grey.withOpacity(0.2), // 백그라운드 막대 색상
                ),
              )
            ],
          );
        }).toList(),
      ),
    ),
  );
}
