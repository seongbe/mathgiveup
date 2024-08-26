import 'dart:convert';
import 'package:mathgame/auth/auth_token.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/api/api.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/router/homepage.dart';
import 'package:mathgame/userInfo/userPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class NickChange extends StatelessWidget {
  final TextEditingController nickController = TextEditingController();

  NickChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '닉네임 변경'),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildContent(),
        ],
      ),
    );
  }

  // 배경 이미지 빌드
  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.6), // 흰색 음영과 투명도 조절
            BlendMode.modulate, // 흰색 음영을 적용
          ),
        ),
      ),
    );
  }

  // 메인 컨텐츠 빌드
  Widget _buildContent() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      children: [
        Row(
          children: [
            Text(
              '현재 닉네임 : ',
              style: skyboriBaseTextStyle.copyWith(fontSize: 20),
            ),
            _buildCurrentNickname(),
          ],
        ),
        SizedBox(height: 10.0),
        _buildNicknameInput(),
        SizedBox(height: 50.0),
        _buildChangeButton(),
      ],
    );
  }

  // 현재 닉네임을 표시하는 위젯 빌드
  Widget _buildCurrentNickname() {
    return FutureBuilder<String?>(
      future: _getNickname(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Text(
            snapshot.data ?? '닉네임 없음',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          );
        } else {
          return Text(
            '닉네임 없음',
            style: skyboriBaseTextStyle.copyWith(fontSize: 25),
          );
        }
      },
    );
  }

  // 닉네임 입력 필드 빌드
  Widget _buildNicknameInput() {
    return SizedBox(
      width: double.infinity,
      child: CustomTextField(
        controller: nickController,
        hintText: "변경할 닉네임을 입력하세요",
      ),
    );
  }

  // 닉네임 변경 버튼 빌드
  Widget _buildChangeButton() {
    return Center(
      child: CustomButton(
        width: 300,
        height: 50,
        text: "닉네임 변경하기",
        onPressed: () {
          _nickNameCheck();
        },
      ),
    );
  }

  // 현재 닉네임 가져오기
  Future<String?> _getNickname() async {
    return await UserPreferences.getNickname();
  }

  // 닉네임 입력 확인하기
  void _nickNameCheck() async {
    final currentNickname = await _getNickname();
    final newNickname = nickController.text.trim();

    if (newNickname.isEmpty) {
      _showSnackbar(
        title: '닉네임 변경 실패',
        message: '닉네임을 입력해주세요.',
        isError: true,
      );
    } else if (newNickname == currentNickname) {
      _showSnackbar(
        title: '닉네임 변경 실패',
        message: '현재 닉네임과 같은 닉네임입니다.',
        isError: true,
      );
    } else {
      _changeNickName(newNickname);
    }
  }

  // 닉네임 변경 요청
  Future<void> _changeNickName(String newNickname) async {
    final token = await AuthTokenStorage.getToken();
    final url = Uri.parse('$membersUrl/change_nickname');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'newNickname': newNickname}),
    );

    // 디버깅
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      await UserPreferences.saveNickname(newNickname); // 닉네임 저장
      Future.delayed(Duration(seconds: 2), () {
        Get.to(() => Homepage());
      });
      _showSnackbar(
        title: '닉네임 변경 성공',
        message: '입력하신 닉네임으로 변경되었습니다.',
      );
    } else {
      _showSnackbar(
        title: '닉네임 변경 실패',
        message: '닉네임 변경에 실패했습니다. 다시 시도해 주세요.',
        isError: true,
      );
    }
  }

  // Snackbar 표시 함수
  void _showSnackbar({
    required String title,
    required String message,
    bool isError = false,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
      colorText: isError ? Colors.red : Colors.black,
      borderRadius: 10,
      margin: EdgeInsets.all(16),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
