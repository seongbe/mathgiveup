import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 임시 학습 데이터
final List<DateTime> specialDays = [
  DateTime(2024, 7, 4),
  DateTime(2024, 7, 9),
  DateTime(2024, 7, 13),
  DateTime(2024, 7, 15),
  DateTime(2024, 7, 18),
  DateTime(2024, 7, 23),
  DateTime(2024, 7, 24),
  DateTime(2024, 7, 25),
  DateTime(2024, 7, 27),
  DateTime(2024, 7, 28),
  DateTime(2024, 7, 29),
  DateTime(2024, 7, 30),
  DateTime(2024, 7, 31),
];

class ProgressModel with ChangeNotifier {
  int _currentDay = 0;
  final int _targetDay = 7;

  ProgressModel() {
    _calculateCurrentDay();
  }

  int get currentDay => _currentDay;
  int get targetDay => _targetDay;

  void _calculateCurrentDay() {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    // 어제까지 연속으로 학습한 날 계산
    int count = 0;
    DateTime checkDate = yesterday;

    while (specialDays.contains(_removeTime(checkDate))) {
      count++;
      checkDate = checkDate.subtract(Duration(days: 1));
    }

    _currentDay = count;
  }

  void incrementDay() {
    if (_currentDay < _targetDay) {
      _currentDay++;
      notifyListeners();
    }
  }

  DateTime _removeTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
