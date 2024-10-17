import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mathgame/api/api.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/test/mainTestPage.dart';
import 'package:mathgame/auth/auth_token.dart';

class JoinProcess {
  final grades = ['1학년', '2학년', '3학년'];
  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController passwordController;
  final TextEditingController checkPasswordController;
  final TextEditingController nicknameController;
  final TextEditingController birthController;
  final TextEditingController schoolController;

  JoinProcess({
    required this.nameController,
    required this.idController,
    required this.passwordController,
    required this.checkPasswordController,
    required this.nicknameController,
    required this.birthController,
    required this.schoolController,
  });

  String idErrorMessage = '';
  Color idErrorColor = Colors.red;
  bool isIdVerified = false;
  int selectedButtonIndex = -1;
  String email = '';

  void initEmail(String userEmail) {
    email = userEmail;
  }

  bool isValidId(String id) {
    // 아이디 유효성 검사
    final regex = RegExp(r'^[a-z][a-z0-9]{3,11}$');
    return regex.hasMatch(id);
  }

  bool isValidPassword(String password) {
    // 비밀번호 유효성 검사
    final regex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    print(password);
    bool result = regex.hasMatch(password);
    print("비밀번호 확인 결과: ${result}");
    return regex.hasMatch(password);
  }

  Future<void> checkID(List<String> existingIds, State state) async {
    try {
      final url = Uri.parse(
        '$membersUrl/check-loginId'
        '?loginId=${Uri.encodeComponent(idController.text)}',
      );

      final response = await http.post(url);

      // 디버깅
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (!isValidId(idController.text)) {
        idErrorMessage = "유효하지 않은 아이디 형식입니다.";
        idErrorColor = Colors.red;
        isIdVerified = false;
      } else if (idController.text.isEmpty) {
        idErrorMessage = '아이디를 입력해 주세요.';
        idErrorColor = Colors.red;
        isIdVerified = false;
      } else if (response.statusCode == 200) {
        idErrorMessage = '사용 가능한 아이디입니다.';
        idErrorColor = Colors.blue;
        isIdVerified = true;
      } else {
        idErrorMessage = '이미 사용 중인 아이디입니다.';
        idErrorColor = Colors.red;
        isIdVerified = false;
      }
    } catch (e) {
      print('Error occurred: $e'); // 예외 메시지 출력
      idErrorMessage = '아이디 확인 중 오류가 발생했습니다. 인터넷 연결을 확인하세요.';
      idErrorColor = Colors.red;
      isIdVerified = false;
    }

    // UI 갱신
    state.setState(() {});
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> checkField(BuildContext context, State state) async {
    if (nameController.text.isEmpty) {
      showSnackBar(context, '이름을 입력해 주세요.');
    } else if (idController.text.isEmpty) {
      showSnackBar(context, '아이디를 입력해 주세요.');
      isIdVerified = false;
    } else if (!isIdVerified) {
      showSnackBar(context, '아이디 중복 검사를 해주세요');
    } else if (passwordController.text.isEmpty ||
        checkPasswordController.text.isEmpty) {
      showSnackBar(context, '비밀번호를 입력해주세요.');
    } else if (passwordController.text != checkPasswordController.text) {
      showSnackBar(context, '비밀번호를 다시 확인해주세요.');
    } else if (!isValidPassword(passwordController.text)) {
      showSnackBar(context, '유효하지 않은 비밀번호 형식입니다.');
    } else if (nicknameController.text.isEmpty) {
      showSnackBar(context, '닉네임을 입력해 주세요.');
    } else if (birthController.text.isEmpty) {
      showSnackBar(context, '생일을 입력해 주세요.');
    } else if (selectedButtonIndex == -1) {
      showSnackBar(context, '학년을 선택해 주세요.');
    } else {
      final url = Uri.parse('$membersUrl/signup');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': nameController.text,
          'loginId': idController.text,
          'loginPwd': passwordController.text,
          'nickname': nicknameController.text,
          'grade': selectedButtonIndex,
          'birthdate': birthController.text,
        }),
      );

      // 디버깅
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // 토큰 저장
        await AuthTokenStorage.saveToken(token);
        print('Token: ${token}');

        // 화면 전환
        Get.to(PopUpPage(
          message: '회원가입이 완료되었습니다.\n확인 버튼을 누르면 실력테스트로 넘어갑니다.',
          onPressed: () {
            Get.to(MainTestPage());
          },
        ));
      } else {
        showSnackBar(context, '회원가입에 실패했습니다. 다시 시도해 주세요.');
      }
    }
  }

  Future<void> selectDate(BuildContext context, State state) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      birthController.text =
          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

      state.setState(() {});
    }
  }

  Future<void> schoolName(String searchName, BuildContext parentContext) async {
    try {
      final url = Uri.parse(
          'https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=a158b0dd00e34efa80c15fee4b98e98f&svcType=api&svcCode=SCHOOL&contentType=json&gubun=midd_list&region=100276&searchSchulNm=${searchName}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<String> schoolNames = [];

        for (var school in data['dataSearch']['content']) {
          schoolNames.add(school['schoolName']);
        }
        print(schoolNames);

        if (schoolNames.isNotEmpty) {
          showSchoolOptionsDialog(parentContext, schoolNames);
        } else {
          showNoResultsDialog(parentContext, searchName);
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> showSchoolSearchDialog(BuildContext context) async {
    final parentContext = context;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String school = '';

        return AlertDialog(
          title: Text('학교 검색'),
          content: TextField(
            //controller: schoolController,
            onChanged: (value) {
              school = value;
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
                schoolName(school, parentContext);
                //schoolController.text = school;
                print('입력된 학교: $school');
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void showSchoolOptionsDialog(BuildContext context, List<String> schoolNames) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('검색 결과'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: schoolNames
                .map((name) => ListTile(
                      title: Text(name),
                      onTap: () {
                        schoolController.text = name;
                        print('선택된 학교: $name');
                        Navigator.of(context).pop();
                      },
                    ))
                .toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  void showNoResultsDialog(BuildContext context, String searchName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('검색 결과 없음'),
          content: Text('\"$searchName\"에 해당하는 학교를 찾을 수 없습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }
}
