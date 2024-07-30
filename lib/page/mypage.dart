import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/detailnotepage.dart';
import 'package:mathgame/page/learningInfo/studyDaysPage.dart';
import 'package:mathgame/page/setting.dart';
import 'package:mathgame/page/learningInfo/studyDaysPage.dart';
import 'package:mathgame/model/progressModel.dart';
import 'package:mathgame/page/test/mainTestPage.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // 배경 이미지 설정
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'), // 배경 이미지 경로
              fit: BoxFit.cover, // 이미지 크기 조정 방식
            ),
          ),
        ),
        // 배경 이미지 위에 배치될 위젯들
        ListView(
          children: [
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 120,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/image copy 2.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('실력 등급')
                        ],
                      ),
                      SizedBox(width: 20),
                      VerticalDivider(
                        color: Color.fromARGB(255, 211, 211, 211),
                        thickness: 1.5,
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => StudyDaysPage());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/image copy.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('연속 학습 일수')
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      VerticalDivider(
                        color: Color.fromARGB(255, 211, 211, 211),
                        thickness: 1.5,
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/image.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('학습 통계')
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Divider(
                  color: Colors.white,
                  thickness: 4,
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  child: Row(
                    children: [
                      Text(
                        '내가 작성한 글',
                        style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.arrow_circle_right_outlined),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        '내가 작성한 댓글',
                        style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.arrow_circle_right_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.white,
                  thickness: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => Setting());
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          '설정',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                        Icon(Icons.settings),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 200),
                CustomButton(
                  text: "실력 테스트 하기",
                  onPressed: () {
                    Get.to(MainTestPage());
                  },
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
