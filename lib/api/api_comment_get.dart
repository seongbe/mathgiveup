import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';

Future<List<Map<String, dynamic>>> getComments(int commentId) async {
  final url = Uri.parse('$mathUrl/community/comments/$commentId'); 
  final token = await AuthTokenStorage.getToken(); 

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body); // JSON 데이터를 디코딩
    List<Map<String, dynamic>> comments = jsonData.cast<Map<String, dynamic>>(); // JSON 데이터를 Map으로 캐스팅하여 리스트로 반환
    return comments;
  } else {
    print('Failed to fetch comments with status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return []; // 오류가 발생하면 빈 리스트를 반환
  }
}
