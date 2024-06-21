import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/controller/NavigationController.dart';
import 'package:mathgame/page/communitypage.dart';
import 'package:mathgame/page/mypage.dart';
import 'package:mathgame/page/odabnotepage.dart';

class Homepage extends StatelessWidget {
  final NavigationController navigationController = Get.put(NavigationController());

  final List<Widget> pages = [
    HomePageContent(), // 홈 페이지 컨텐츠
    Communitypage(),
    Odabnotepage(),
    Mypage(),
  ];

  

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Game'),
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Page', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Text('Start Game'),
          ),
        ],
      ),
    );
  }
}
