import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mathgame/auth/auth_token.dart';
import 'package:mathgame/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/router/homepage.dart';
import 'package:mathgame/userInfo/userPreferences.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '프로필 변경'),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ProfileWidget(),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  ProfileWidget({super.key});

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String selectedIconPath = 'assets/images/icon1.png';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final loadedIconPath = await UserPreferences.getIcon();
    setState(() {
      selectedIconPath =
          loadedIconPath ?? 'assets/images/icon1.png'; // 기본 아이콘 설정
    });
  }

  // 아이콘 선택 버튼
  Widget iconButton({required String assetPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              selectedIconPath,
              width: 120,
              height: 120,
            ),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              String assetPath = 'assets/images/icon${(index + 1)}.png';
              return iconButton(
                assetPath: assetPath,
                onTap: () {
                  setState(() {
                    selectedIconPath = assetPath;
                  });
                  print('Button ${index + 1} Click');
                },
              );
            },
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 50,
              child: CustomButton(
                text: '프로필 변경하기',
                fontSize: 25,
                onPressed: () {
                  _changeIcon(selectedIconPath);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _changeIcon(String selectedIconPath) async {
    final token = await AuthTokenStorage.getToken();
    final url = Uri.parse('$membersUrl/change_icon');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'newIcon': selectedIconPath}), // JSON으로 인코딩
    );

    // 디버깅
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      await UserPreferences.saveIcon(selectedIconPath);
      Future.delayed(Duration(seconds: 2), () {
        Get.to(Homepage());
      });
      Get.snackbar(
        '아이콘 변경 성공',
        '선택한 아이콘으로 변경되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        colorText: Colors.black,
        borderRadius: 10,
        margin: EdgeInsets.all(16),
        snackStyle: SnackStyle.FLOATING,
      );
    } else {
      Get.snackbar(
        '아이콘 변경 실패',
        '아이콘 변경에 실패하였습니다. 다시 시도해 주세요.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        colorText: Colors.red,
        borderRadius: 10,
        margin: EdgeInsets.all(16),
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }
}
