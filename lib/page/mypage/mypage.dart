import 'dart:async'; // Import for Future
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/mypage/learningInfo/learningStatistics.dart';
import 'package:mathgame/page/join/loginPage.dart';
import 'package:mathgame/page/odabnote/detailnotepage.dart';
import 'package:mathgame/page/mypage/learningInfo/studyDaysPage.dart';
import 'package:mathgame/page/mypage/rankgrade.dart';
import 'package:mathgame/page/mypage/statics.dart';
import 'package:mathgame/page/setting/setting.dart';
import 'package:mathgame/model/progressModel.dart';
import 'package:mathgame/page/test/mainTestPage.dart';
import 'package:mathgame/userInfo/userPreferences.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  Future<String?> _getNickname() async {
    return await UserPreferences.getNickname();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/icon1.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<String?>(
                      future: _getNickname(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _buildInfoCard(context),
              SizedBox(height: 20),
              Divider(color: Colors.white, thickness: 1),
              SizedBox(height: 10),
              _buildMenuItem('내가 작성한 글', Icons.arrow_circle_right_outlined),
              SizedBox(height: 10),
              _buildMenuItem('내가 작성한 댓글', Icons.arrow_circle_right_outlined),
              SizedBox(height: 10),
              Divider(color: Colors.white, thickness: 1),
              GestureDetector(
                onTap: () {
                  Get.to(() => Setting());
                },
                child: _buildMenuItem('설정', Icons.settings, paddingTop: 20),
              ),
              GestureDetector(
                onTap: () {Get.to(() => LoginPage());},
                child: _buildMenuItem('로그아웃', Icons.logout, paddingTop: 20),
              ),
              SizedBox(height: 50),
              CustomButton(
                text: "실력 테스트 하기",
                onPressed: () {
                  Get.to(MainTestPage());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 120,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildInfoItem(
              title: '실력 등급',
              imagePath: 'assets/images/image copy 2.png',
              onTap: () => Get.to(() => Rankgrade()),
            ),
          ),
          Flexible(
            flex: 0,
            child: VerticalDivider(
              color: Color.fromARGB(255, 211, 211, 211),
              thickness: 1.5,
            ),
          ),
          Expanded(
            child: _buildInfoItem(
              title: '연속 학습 일수',
              imagePath: 'assets/images/image copy.png',
              onTap: () => Get.to(() => StudyDaysPage()),
            ),
          ),
          Flexible(
            flex: 0,
            child: VerticalDivider(
              color: Color.fromARGB(255, 211, 211, 211),
              thickness: 1.5,
            ),
          ),
          Expanded(
            child: _buildInfoItem(
              title: '학습 통계',
              imagePath: 'assets/images/image.png',
              onTap: () => Get.to(() => LearningStatistics()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: skyboriBaseTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {double paddingTop = 0}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, paddingTop, 0, 0),
      child: Row(
        children: [
          Text(
            title,
            style: skyboriBaseTextStyle.copyWith(fontSize: 20),
          ),
          SizedBox(width: 10),
          Icon(icon),
        ],
      ),
    );
  }
}
