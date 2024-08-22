import 'package:flutter/material.dart';
import 'package:mathgame/page/mypage/learningInfo/api_studyDays.dart';

class ProgressModel with ChangeNotifier {
  int _currentDay = 0;
  int _targetDay = 7; // 초기값 설정

  ProgressModel() {
    _initialize();
  }

  int get currentDay => _currentDay;
  int get targetDay => _targetDay;

  Future<void> _initialize() async {
    await fetchStudyDays(); // 전역 변수 specialDays를 초기화
    _calculateCurrentDay(); // 초기화 후에 현재 날 계산
    _calculateTargetDay();
    notifyListeners(); // 변경 사항을 UI에 알림
  }

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
