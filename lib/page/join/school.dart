import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class School {
  final String searchSchoolName;

  School({required this.searchSchoolName});

  Future<void> schoolName(List<String> existingIds, State state) async {
    try {
      final url = Uri.parse(
          'https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=a158b0dd00e34efa80c15fee4b98e98f&svcType=api&svcCode=SCHOOL&contentType=json&gubun=midd_list&region=100276&searchSchulNm=${searchSchoolName}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        //print('Response: ${response.body}');
        final data = jsonDecode(response.body);
        List<String> schoolNames = [];

        for (var school in data['dataSearch']['content']) {
          schoolNames.add(school['schoolName']);
        }
        print(schoolNames);
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void _showsSchoolSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String address = '';

        return AlertDialog(
          title: Text('학교 검색'),
          content: TextField(
            onChanged: (value) {
              address = value;
            },
            decoration: InputDecoration(
              hintText: '학교 이름을 입력하세요',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 여기서 주소를 처리할 수 있습니다
                print('입력된 학교: $address');
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
