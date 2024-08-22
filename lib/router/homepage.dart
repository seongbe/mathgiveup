import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mathgame/component/button.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/controller/NavigationController.dart';
import 'package:mathgame/game/Game.dart';
import 'package:mathgame/game/GamePage1.dart';
import 'package:mathgame/game/GamePage2.dart';
import 'package:mathgame/game/GamePage3.dart';
import 'package:mathgame/page/community/communitypage.dart';
import 'package:mathgame/page/odabnote/detailnotepage.dart';
import 'package:mathgame/page/mypage/mypage.dart';
import 'package:mathgame/page/odabnote/odabnotepage.dart';
import 'package:mathgame/page/setting/setting.dart';

class Homepage extends StatelessWidget {
  final NavigationController navigationController 
  = Get.find<NavigationController>();


  final List<Widget> pages = [
    HomePageContent(), // 홈 페이지 컨텐츠
    Communitypage(),
    Odabnotepage(),
    Mypage(),
    GameSelectPage(),
   
  ];

  

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
          navigationController.selectedIndex.value == 5 ? 'Detail Notepage' : 'Smath',
          style: skyboriBaseTextStyle,
        ),
        leading:  Container(
          child: GestureDetector(
                  onTap: () {
                    Get.to(() => Setting());
                  },
                  child: Container(
                     
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Icon(Icons.settings),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      body: Obx(() => pages[navigationController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: '오답노트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '마이페이지',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: '게임페이지',
          ),
 
          
          
        ],
        currentIndex: navigationController.selectedIndex.value,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
         showUnselectedLabels: true, // 선택되지 않은 항목의 라벨도 보이게 설정
        onTap: (index) {
          navigationController.changePage(index);
        },
      )),
    
    );
  }
}



// lib/page/homepage_content.dart 

class HomePageContent extends StatelessWidget {
  final List<Notice> notices = [
    Notice(
      title: "첫번쨰 공지사항",
      description: "오늘은 게임 좀 쉬세요.",
      date: DateTime.now(),
    ),
    Notice(
      title: "두번째 공지사항",
      description: "앞으로 수학게임이 5일간 서버 점검에 들어갈 예정입니다.",
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Notice(
      title: "세번째 공지사항",
      description: "앞으로 수학게임이 5일간 서버 점검에 들어갈 예정입니다.",
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Notice(
      title: "네번째 공지사항",
      description: "앞으로 수학게임이 5일간 서버 점검에 들어갈 예정입니다.",
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    // 더 많은 공지사항을 추가하세요
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => GamePage());
                    },
                    child: Container(
                      
                    width: 161,
                    height: 185,
                     
                    decoration: BoxDecoration(
                      image: DecorationImage(
                       image: AssetImage('assets/images/mathgame1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                                    ),
                  ),
                SizedBox(width: 20,),
                 GestureDetector(
                  onTap: () {
                    Get.to(() => GamePage2());
                  },
                   child: Container(
                    width: 161,
                    height: 185,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/mathgame2.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                                   ),
                 ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30,),
                   Container(
                    
                  width: 75,
                  height: 75,
                   
                  decoration: BoxDecoration(
                    image: DecorationImage(
                     image: AssetImage('assets/images/notice.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 70,),
                Text('공지사항',
                  style: skyboriBaseTextStyle.copyWith(fontSize: 30)
                  
                )

                ],
              ),
             Container(
                width: 400,
                height: 300, // 공지사항 컨테이너 높이 조절
                 decoration: BoxDecoration(
                color: BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(16.0), // 모서리를 둥글게 설정
               ),
                
                
                child: ListView.builder(
                  itemCount: notices.length,
                  itemBuilder: (context, index) {
                    return NoticeContainer(notice: notices[index]);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20,),
                    Text('오늘의목표',
                    style: skyboriBaseTextStyle.copyWith(fontSize: 30)),
                  ],
                ),
              ),
               Container(
                width: 400,
                height: 120, // 공지사항 컨테이너 높이 조절
                 decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(16.0), // 모서리를 둥글게 설정
                  
               ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Goal(text: '0승/5승',
                    text2: '오늘의 승리수',),
                    Goal(text: '0승/5승',
                    text2: '오늘의 승리수',),
                    Goal(text: '0승/5승',
                    text2: '오늘의 승리수',),
                    
                  ],
                ),
                
                 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Container(
                      width: 161,
                      height: 185,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/청룡.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text('SMATH',
                    style: skyboriBaseTextStyle.copyWith(fontSize: 40),),
                  ],
                ),
              
            CustomButton2(
              text: '계속플레이',
              text2: '스테이지2부터',
              width:  320,
              height:  90,
              onPressed: () {
                Get.to(()=>GamePage3());
              },
            ),
            SizedBox(height: 30,),
            CustomButton(
              text: '처음부터하기',
              width:  231,
              height:  55,
              onPressed: () {
                 Get.to(()=>GamePage3());
              },
            ),
            ],
          ),
        ],
      ),
    );
  }
}
class Notice {
  final String title;
  final String description;
  final DateTime date;

  Notice({required this.title, required this.description, required this.date});
}


 

class NoticeContainer extends StatelessWidget {
  final Notice notice;

  const NoticeContainer({Key? key, required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notice.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
         DateFormat('yyyy-MM-dd').format(notice.date),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            notice.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class Goal extends StatelessWidget {
  final String text;
  final String text2;
  const Goal({super.key, 
  required this.text,
   required this.text2
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 71,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(text,
          style: skyboriBaseTextStyle.copyWith(fontSize: 14),
          ),
          SizedBox(height: 5,),
          Text(text2,
          style: skyboriBaseTextStyle.copyWith(fontSize: 10),
          ),


        ],
      ),

      );
  }
}
