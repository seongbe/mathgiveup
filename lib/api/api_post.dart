import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';
Future<void> postData(String title, String content) async {
  final url = Uri.parse('$mathUrl/community/posts');
  final token = await AuthTokenStorage.getToken();

  if (token == null) {
    print('No token found');
    return;
  }

  print('Sending POST request to $url');
  print('Headers: ${{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  }}');
  print('Body: ${{
    'title': title,
    'content': content,
  }}');

  try {
    final response = await http.post(
      url,
      
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'title': title,
        'content': content,
      }),
    );

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      print('New Post ID: ${data['id']}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

