import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';

// 전역 변수 선언
List<DateTime> specialDays = [];

Future<void> fetchStudyDays() async {
  final DateTime now = DateTime.now();

  // 현재 달과 직전 달의 연도와 월을 계산
  DateTime currentMonthDate = DateTime(now.year, now.month, 1);
  DateTime previousMonthDate = DateTime(now.year, now.month - 1, 1);

  final String currentMonthYearMonth =
      DateFormat('yyyy-MM').format(currentMonthDate);
  final String previousMonthYearMonth =
      DateFormat('yyyy-MM').format(previousMonthDate);

  final token = await AuthTokenStorage.getToken();

  if (token == null) {
    print('No token found');
    return;
  }

  // 현재 달 API 호출
  final currentMonthUrl = Uri.parse(
      '$mathUrl/learning/records/monthly?yearMonth=$currentMonthYearMonth');
  final previousMonthUrl = Uri.parse(
      '$mathUrl/learning/records/monthly?yearMonth=$previousMonthYearMonth');

  // API 호출을 비동기적으로 수행
  final currentMonthResponseFuture = http.get(
    currentMonthUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  final previousMonthResponseFuture = http.get(
    previousMonthUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  // 두 API 호출의 응답을 기다림
  final currentMonthResponse = await currentMonthResponseFuture;
  final previousMonthResponse = await previousMonthResponseFuture;

  // 디버깅
  print(
      'Current month response status code: ${currentMonthResponse.statusCode}');
  print('Current month response body: ${currentMonthResponse.body}');
  print(
      'Previous month response status code: ${previousMonthResponse.statusCode}');
  print('Previous month response body: ${previousMonthResponse.body}');

  if (currentMonthResponse.statusCode == 200) {
    final currentMonthData = jsonDecode(currentMonthResponse.body);
    final currentMonthDays = (currentMonthData['learningDays'] as List<dynamic>)
        .map((day) => DateTime.parse(day))
        .toList();
    specialDays.addAll(currentMonthDays);
  } else {
    print('Failed to load current month study days');
  }

  if (previousMonthResponse.statusCode == 200) {
    final previousMonthData = jsonDecode(previousMonthResponse.body);
    final previousMonthDays =
        (previousMonthData['learningDays'] as List<dynamic>)
            .map((day) => DateTime.parse(day))
            .toList();
    specialDays.addAll(previousMonthDays);
  } else {
    print('Failed to load previous month study days');
  }

  print('Special Days: $specialDays'); // 변환된 DateTime 리스트 출력
}
