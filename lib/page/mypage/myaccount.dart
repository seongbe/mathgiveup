import 'package:flutter/material.dart';
import 'package:mathgame/auth/google_sign_in_provider.dart';
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
              ),
            ),
          ),
          // 배경 이미지 위에 배치될 위젯들
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                    child: Row(
                      children: [
                        Text(
                          '아이디 찾기',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                        Icon(Icons.arrow_circle_right_outlined),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
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
                          '비밀번호 찾기',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                        Icon(Icons.arrow_circle_right_outlined),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Provider.of<GoogleSignInProvider>(context,
                              listen: false)
                          .signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                      child: Row(
                        children: [
                          Text(
                            '로그아웃',
                            style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                          ),
                          SizedBox(width: 30),
                          Icon(Icons.logout),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
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
                          '회원탈퇴',
                          style: skyboriBaseTextStyle.copyWith(fontSize: 20),
                        ),
                        SizedBox(width: 30),
                        Icon(Icons.delete)
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
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
