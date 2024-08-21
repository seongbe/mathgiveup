import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';

Future<bool> updatePost(int postId, String newTitle, String newContent) async {
  final url = Uri.parse('$mathUrl/community/posts/$postId'); // 해당 게시물의 ID를 사용하여 API 호출
  final token = await AuthTokenStorage.getToken();

  if (token == null) {
    print('No token found');
    return false;
  }

  print('Request URL: $url');
  print('Request Headers: ${{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  }}');
  print('Request Body: ${{
    'title': newTitle,
    'content': newContent,
  }}');

  final response = await http.patch(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({
      'title': newTitle,
      'content': newContent,
    }),
  );


  if (response.statusCode == 200) {
    print('Post updated successfully');
    return true;
  } else {
    print('Failed to update post with status: ${response.statusCode}');
    return false;
  }
}
