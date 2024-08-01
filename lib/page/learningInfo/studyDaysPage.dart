import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mathgame/page/detailnotepage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/model/progressModel.dart';

class StudyDaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '연속 학습 일수'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          MyWidget(),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 날짜 객체에서 시간 부분을 제거하는 함수
  DateTime removeTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    final progressModel = Provider.of<ProgressModel>(context);
    double progressValue = progressModel.currentDay / progressModel.targetDay;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '뱃지 지급까지 ${progressModel.targetDay - progressModel.currentDay}일 남았어요',
                    style: skyboriBaseTextStyle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '연속 학습 ',
                          style: skyboriBaseTextStyle.copyWith(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                        TextSpan(
                          text: '${progressModel.currentDay}',
                          style: skyboriBaseTextStyle.copyWith(
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(
                          text: '일차',
                          style: skyboriBaseTextStyle.copyWith(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Text(
                '${progressModel.currentDay}/${progressModel.targetDay} days',
                style: skyboriBaseTextStyle.copyWith(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: progressValue,
            minHeight: 15,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          // 달력
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (specialDays.contains(removeTime(selectedDay))) {
                setState(() {
                  _selectedDay = removeTime(selectedDay);
                  _focusedDay = focusedDay;
                  print("Selected special day: $selectedDay");
                  Get.to(() => DetailNotepage());
                });
              } else {
                print("Selected non-special day: $selectedDay");
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              leftChevronVisible: true,
              rightChevronVisible: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMM(locale).format(date),
              titleTextStyle: TextStyle(fontSize: 16.0),
            ),
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, date) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          DateFormat.yMMMM().format(date),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime.now();
                        });
                      },
                      child: Text(
                        '오늘',
                        style: skyboriBaseTextStyle,
                      ),
                    ),
                  ],
                );
              },
              selectedBuilder: (context, date, _) {
                bool isSpecialDay = specialDays.contains(removeTime(date));
                print("Selected date: $date, isSpecialDay: $isSpecialDay");
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              todayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              defaultBuilder: (context, date, _) {
                bool isSpecialDay = specialDays.contains(removeTime(date));
                if (isSpecialDay) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 50),
          // Center(
          //   child: Column(
          //     children: [
          //       Text(
          //           '연속 학습 일수: ${progressModel.currentDay}/${progressModel.targetDay} days',
          //           style: skyboriBaseTextStyle.copyWith(fontSize: 15)),
          //       SizedBox(height: 10),
          //       LinearProgressIndicator(
          //         value: progressValue,
          //         minHeight: 10,
          //         backgroundColor: Colors.grey[300],
          //         color: Colors.blue,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
