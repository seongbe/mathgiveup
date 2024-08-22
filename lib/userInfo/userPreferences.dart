import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
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
}
