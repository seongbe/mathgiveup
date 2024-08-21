import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';

Future<List<Map<String, dynamic>>?> getPosts() async {
  final url = Uri.parse('$mathUrl/community/posts/my'); // 게시물 목록을 가져오는 API 엔드포인트
  final token = await AuthTokenStorage.getToken();

  if (token == null) {
    print('No token found');
    return null;
  }

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> posts = json.decode(response.body);
    return posts.cast<Map<String, dynamic>>();
  } else {
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}
