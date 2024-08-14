import 'dart:convert';
import 'package:http/http.dart' as http;

class WolframAlphaAPI {
  final String apiKey = 'LWYX87-LR62EH3Y59';

  Future<String> fetchSolution(String query) async {
    final response = await http.get(
      Uri.parse(
        'http://api.wolframalpha.com/v2/query?input=$query&format=plaintext&output=JSON&appid=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['queryresult']['pods'][1]['subpods'][0]['plaintext'];
    } else {
      throw Exception('Failed to load solution');
    }
  }
}
