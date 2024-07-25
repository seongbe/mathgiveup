import 'package:flutter/material.dart';

class ProgressModel with ChangeNotifier {
  int _currentDay = 6;
  final int _targetDay = 7;

  int get currentDay => _currentDay;
  int get targetDay => _targetDay;

  void incrementDay() {
    if (_currentDay < _targetDay) {
      _currentDay++;
      notifyListeners();
    }
  }
}
