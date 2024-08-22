import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';

// 게시물 저장
Future<void> savePostLocally(Map<String, dynamic> post) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> savedPosts = prefs.getStringList('saved_posts') ?? [];
  
  // 새 게시물 추가
  savedPosts.add(json.encode(post));
  
  // 업데이트된 리스트를 저장
  await prefs.setStringList('saved_posts', savedPosts);
}

// 저장된 게시물 불러오기
Future<List<Map<String, dynamic>>> getSavedPosts() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> savedPosts = prefs.getStringList('saved_posts') ?? [];
  
  return savedPosts.map((post) => json.decode(post)).cast<Map<String, dynamic>>().toList();
}

// 서버에 게시물 POST 요청
Future<void> postData(String title, String content) async {
  final url = Uri.parse('$mathUrl/community/posts');
  final token = await AuthTokenStorage.getToken();

  if (token == null) {
    print('No token found');
    return;
  }

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

      // 게시물이 성공적으로 업로드된 경우 로컬에 저장
      await savePostLocally({
        'id': data['id'],
        'title': title,
        'content': content,
      });

    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

// 로그인 후 저장된 게시물 불러오기 예시
Future<void> loadPostsAfterLogin() async {
  List<Map<String, dynamic>> savedPosts = await getSavedPosts();

  if (savedPosts.isNotEmpty) {
    print('Saved Posts:');
    for (var post in savedPosts) {
      print('Post ID: ${post['id']}, Title: ${post['title']}, Content: ${post['content']}');
    }
  } else {
    print('No saved posts found.');
  }
}
