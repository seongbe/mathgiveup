import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/auth/google_sign_in_provider.dart';
import 'package:mathgame/page/find/findIdPage.dart';
import 'package:mathgame/page/find/findPasswdPage.dart';
import 'package:provider/provider.dart';
import 'package:mathgame/const/styles.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 계정', style: skyboriBaseTextStyle.copyWith(fontSize: 24)),
        backgroundColor: Colors.transparent, // AppBar 배경을 투명하게 설정
        elevation: 0, // 그림자 제거
      ),
      body: Stack(
        children: [
          Container(
            // 배경 이미지 설정
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'), // 배경 이미지 경로
                fit: BoxFit.cover, // 이미지 크기 조정 방식
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7), // 흰색 음영과 투명도 조절
                  BlendMode.modulate, // 흰색 음영을 적용
                ),
              ),
            ),
          ),
          // 배경 이미지 위에 배치될 위젯들
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildMenuItem(
                    '아이디 찾기',
                    Icons.arrow_circle_right_outlined,
                    onPressed: () => Get.to(() => FindIdPage()),
                  ),
                  _buildDivider(context),
                  _buildMenuItem(
                    '비밀번호 재설정',
                    Icons.arrow_circle_right_outlined,
                    onPressed: () => Get.to(() => FindPasswdPage()),
                  ),
                  _buildDivider(context),
                  _buildMenuItem(
                    '로그아웃',
                    Icons.logout,
                    onPressed: () {},
                  ),
                  _buildDivider(context),
                  _buildMenuItem(
                    '회원탈퇴',
                    Icons.delete,
                  ),
                  _buildDivider(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon,
      {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed, // onPressed 콜백을 설정하여 클릭 이벤트를 처리
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
        child: Row(
          children: [
            Text(
              title,
              style: skyboriBaseTextStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(width: 10),
            Icon(icon),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: const Divider(
        color: Colors.white,
        thickness: 2,
      ),
    );
  }
}
