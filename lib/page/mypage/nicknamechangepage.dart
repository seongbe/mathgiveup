import 'package:flutter/material.dart';
import 'package:mathgame/const/styles.dart';

class nickchange extends StatelessWidget {
  final TextEditingController nickController = TextEditingController();
  bool keepLoggedIn = false;
  nickchange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('닉네임 변경', style: skyboriBaseTextStyle.copyWith(fontSize: 24)),
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
              ),
            ),
          ),
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                    child: Text(
                      "변경할 닉네임을 입력해주세요",
                      style: skyboriHintTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "닉네임",
                          style: skyboriBaseTextStyle.copyWith(fontSize: 30),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 250,
                              child: CustomTextField(
                                controller: nickController,
                                hintText: "닉네임 입력",
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                                text: "중복확인", fontSize: 20, onPressed: () {}),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                                width: 300,
                                height: 50,
                                text: "닉네임 변경하기",
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
