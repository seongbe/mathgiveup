import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mathgame/api/api.dart';
import 'dart:convert';

import 'package:mathgame/auth/auth_token.dart';

class PostDetailController extends GetxController {
  var comments = <Map<String, dynamic>>[].obs; // 댓글 목록 상태 관리
  var isLoading = true.obs; // 로딩 상태 관리



   @override
  void onInit() {
    super.onInit();
    // 초기화 작업이 필요하면 여기에서 실행
  }

  // 댓글 가져오기 함수
  Future<void> fetchComments(int postId) async {
    isLoading.value = true;
    final url = Uri.parse('$mathUrl/community/comments/post/$postId'); 
    final token = await AuthTokenStorage.getToken();

    if (token == null) {
      print('Token not found');
      isLoading.value = false;
      return;
    }

    try {
       print('Fetching comments from: $url'); 
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        comments.assignAll(jsonData.cast<Map<String, dynamic>>());
      } else {
        print('Failed to fetch comments with status: ${response.statusCode}');
         print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 댓글 추가 함수
  Future<void> addComment(int postId, String commentContent) async {
      final url = Uri.parse('$mathUrl/community/comments'); 
    final token = await AuthTokenStorage.getToken();

    if (token == null) {
      print('Token not found');
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
        'content': commentContent,
        'postId': postId, // postId를 함께 전송
      }),
    
      );

        if (response.statusCode == 201 || response.statusCode == 200) { // 201이나 200을 성공으로 처리
      fetchComments(postId); // 댓글 추가 후 목록 갱신
      } else {
        print('Failed to post comment with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }



  // 댓글 삭제 함수
  Future<void> deleteComments(int commentId) async {
    isLoading.value = true;
    final url = Uri.parse('$mathUrl/community/comments/$commentId'); 
    final token = await AuthTokenStorage.getToken();

    if (token == null) {
      print('Token not found');
      isLoading.value = false;
      return;
    }

    try {
       print('Fetching comments from: $url'); 
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
      // 댓글 삭제 후 UI 갱신 또는 목록 갱신
     comments.removeWhere((comment) => comment['id'] == commentId);
      // UI 갱신을 위해 isLoading을 false로 설정합니다.
      isLoading.value = false;
      } else {
        print('Failed to fetch comments with status: ${response.statusCode}');
         print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}



