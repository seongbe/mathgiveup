import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/myaccount.dart';
import 'package:mathgame/page/nicknamechangepage.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
   bool isSwitched1 = false; 
   bool isSwitched2 = false; 
   bool isSwitched3 = false; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정', style: skyboriBaseTextStyle.copyWith(fontSize: 24)),
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
          // 배경 이미지 위에 배치될 위젯들
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                     onTap: (){
                    Get.to(() => MyAccount());
                  },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                      child: Row(
                        children: [
                          Text(
                            '내계정',
                            style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                          ),
                          SizedBox(width: 30),
                          Icon(Icons.arrow_circle_right_outlined),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                    child: Row(
                      children: [
                        Text(
                          '아이콘 변경',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                        Icon(Icons.arrow_circle_right_outlined),
                      ],
                    ),
                  ),
                    Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                    Get.to(() => nickchange());
                  },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                      child: Row(
                        children: [
                          Text(
                            '닉네임 변경',
                            style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                          ),
                          SizedBox(width: 30),
                          Icon(Icons.arrow_circle_right_outlined),
                        ],
                      ),
                    ),
                  ),
                   
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                    child: Row(
                      children: [
                        Text(
                          '알림',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                         Switch(
                          value: isSwitched1,
                          onChanged: (value) {
                            setState(() {
                              isSwitched1 = value;
                            });
                          },
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                   
                    Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                    child: Row(
                      children: [
                        Text(
                          '배경음악',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                       Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2 = value;
                            });
                          },
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                   
                   Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                   Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                    child: Row(
                      children: [
                        Text(
                          '효과음',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                         Switch(
                          value: isSwitched3,
                          onChanged: (value) {
                            setState(() {
                              isSwitched3 = value;
                            });
                          },
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                   
                   Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
