import 'package:flutter/material.dart';

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
  DateTime(2024, 8, 1),
  DateTime(2024, 8, 2),
  DateTime(2024, 8, 3),
  DateTime(2024, 8, 4),
  DateTime(2024, 8, 5),
  DateTime(2024, 8, 6),
  DateTime(2024, 8, 7),
  DateTime(2024, 8, 8),
  DateTime(2024, 8, 9),
  DateTime(2024, 8, 10),
  DateTime(2024, 8, 11),
  DateTime(2024, 8, 12),
  DateTime(2024, 8, 13),
  DateTime(2024, 8, 14),
];

class ProgressModel with ChangeNotifier {
  int _currentDay = 0;
  late int _targetDay;

  ProgressModel() {
    _calculateTargetDay();
    _calculateCurrentDay();
  }

  int get currentDay => _currentDay;
  int get targetDay => _targetDay;

  void _calculateCurrentDay() {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    int count = 0;
    DateTime checkDate = yesterday;

    while (specialDays.contains(_removeTime(checkDate))) {
      count++;
      checkDate = checkDate.subtract(Duration(days: 1));
    }

    _currentDay = count;
  }

  void _calculateTargetDay() {
    _targetDay = _currentDay < 7 ? 7 : 30;
  }

  void incrementDay() {
    if (_currentDay < _targetDay) {
      _currentDay++;
      _calculateTargetDay();
      notifyListeners();
    }
  }

  DateTime _removeTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
