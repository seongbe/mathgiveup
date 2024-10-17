import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_model.dart';

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    return data.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
