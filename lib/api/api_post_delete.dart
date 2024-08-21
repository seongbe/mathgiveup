import 'package:http/http.dart' as http;
import 'package:mathgame/api/api.dart';
import 'package:mathgame/auth/auth_token.dart';

Future<bool> deletePost(int postId) async {
  final url = Uri.parse('$mathUrl/community/posts/$postId'); // 해당 게시물의 ID를 사용하여 API 호출
  final token = await AuthTokenStorage.getToken();

  if (token == null) {
    print('No token found');
    return false;
  }

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    print('Post deleted successfully');
    return true;
  } else {
    print('Failed to delete post with status: ${response.statusCode}');
    return false;
  }
}
