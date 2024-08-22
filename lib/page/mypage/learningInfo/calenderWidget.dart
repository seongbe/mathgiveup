import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mathgame/page/mypage/learningInfo/api_studyDays.dart'; // api_studyDays.dart 파일 임포트
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:mathgame/page/odabnote/detailnotepage.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    fetchStudyDays().then((_) {
      setState(() {}); // specialDays를 로드한 후 UI를 업데이트
    });
  }

  DateTime removeTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
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
                  style: TextStyle(fontSize: 12.0),
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
                color: Color(0xFFECF2FF),
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
    );
  }
}
