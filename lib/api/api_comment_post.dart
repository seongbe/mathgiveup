import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';

Future<bool> postComment(String content, int postId) async {
   final url = Uri.parse('$mathUrl/community/comments'); 
     final token = await AuthTokenStorage.getToken(); 
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
       'Authorization': 'Bearer $token',
    },
    body: json.encode({
      'content': content,
      'postId': postId,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Comment posted successfully');
    return true;
  } else {
    print('Failed to post comment with status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return false;
  }
}
