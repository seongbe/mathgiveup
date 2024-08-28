import 'package:mathgame/auth/auth_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // 로그아웃 처리: 모든 데이터와 토큰 삭제
  static Future<void> logout() async {
    await clearAll(); // 모든 SharedPreferences 데이터 삭제
    await AuthTokenStorage.deleteToken(); // 토큰 삭제
  }

  // 모든 데이터 삭제
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // 닉네임 저장
  static Future<void> saveNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
  }

  // 닉네임 읽기
  static Future<String?> getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nickname');
  }

  // 아이콘 저장
  static Future<void> saveIcon(String icon) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('icon', icon);
  }

  // 아이콘 읽기
  static Future<String?> getIcon() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('icon');
  }

  // 수와 연산 정답 비율 저장
  static Future<void> saveScore01(double score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('score01', score);
  }

  // 수와 연산 정답 비율 읽기
  static Future<double?> getScore01() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('score01');
  }

  // 문자와 식 정답 비율 저장
  static Future<void> saveScore02(double score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('score02', score);
  }

  // 문자와 식 정답 비율 읽기
  static Future<double?> getScore02() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('score02');
  }

  // 함수 정답 비율 저장
  static Future<void> saveScore03(double score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('score03', score);
  }

  // 함수 정답 비율 읽기
  static Future<double?> getScore03() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('score03');
  }

  // 도형 정답 비율 저장
  static Future<void> saveScore04(double score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('score04', score);
  }

  // 도형 정답 비율 읽기
  static Future<double?> getScore04() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('score04');
  }
}
