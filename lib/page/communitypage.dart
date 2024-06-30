import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mathgame/const/styles.dart';

class Communitypage extends StatelessWidget {
  final List<Community> communitys = [
    Community(
      title: "게시글",
      number: '3',
      username: "김삿갓",
      description: "같이 게임할분.",
      username2: "김잔디",
      description2: "고수만 들어오셈",
      username3: "김바람",
      description3: "난바람같은남자",
      image1: 'assets/images/profile1.png',
      image2: 'assets/images/profile2.png',
      image3: 'assets/images/profile3.png',
    ),
    Community(
      title: "친구",
      number: '7',
      username: "이채연.",
      description: "longcyanc.com",
      username2: "김용용",
      description2: "chepei.com",
      username3: "김랑롱",
      description3: "naver.com",
      image1: 'assets/images/profile4.png',
      image2: 'assets/images/profile5.png',
      image3: 'assets/images/profile6.png',
    ),
    // 다른 공지사항들을 필요에 따라 추가할 수 있습니다.
  ];
  final chat1 = Chat(
  title: "읽지않은 메세지",
  number: "3",
  username: "유저1",
  description: "안녕하세요",
  username2: "유저2",
  description2: "반갑습니다",
  username3: "유저3",
  description3: "좋은 하루입니다",
);


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
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              ...communitys.map((community) {
                return Column(
                 
                  
                  children: [
                    CommunityContainer(
                      width: MediaQuery.of(context).size.width * 0.8, // 화면 너비의 80%로 설정
                      height: 240, // 원하는 height 값으로 수정
                      community: community,
                    ),
                    Divider(
                      color: Colors.white,
                    ),  
                   
                  ],
                );
              }).toList(),
              SizedBox(height: 30,),
               SizedBox(
                  
                 child: Row(
                   children: [
                    SizedBox(width: 40,),
                     Text('게임 같이하기',
                     style: skyboriTextStyle.copyWith(fontSize: 30),
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                         image: AssetImage('assets/images/mathgame1.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 140,
                      height: 60,
                      text: '같이하기',
                      onPressed: () {
                        
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                 Divider(
                      color: Colors.white,
                    ), 
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChatContainer(chat: chat1),
                  ],
                ),
             
            ],
            
          ),
          
        ),
      ],
    );
  }
}

class Community {
  final String title;
  final String username;
  final String description;
  final String number;

  final String username2;
  final String description2;
  final String username3;
  final String description3;

  final String image1;
  final String image2;
  final String image3;

  Community({
    required this.title,
    required this.username,
    required this.description,
    required this.number,
    required this.username2,
    required this.description2,
    required this.username3,
    required this.description3,
    required this.image1,
    required this.image2,
    required this.image3,
  });
}

class CommunityContainer extends StatelessWidget {
  final Community community;
  final double width;
  final double height;

  const CommunityContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.community,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // 여기서 직접 width와 height를 설정합니다.
      height: height,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                community.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text(
                community.number,
                style: skyboriHintTextStyle,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(community.image1), // 각기 다른 이미지 사용
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.username,
                    style: skyboriHintTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    community.description,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(community.image2), // 각기 다른 이미지 사용
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.username2,
                    style: skyboriHintTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    community.description2,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(community.image3), // 각기 다른 이미지 사용
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.username3,
                    style: skyboriHintTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    community.description3,
                    style: TextStyle(fontSize: 14),
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

class Chat{
 final String title;
  final String username;
  final String description;
  final String number;
  final String username2;
  final String description2;
  final String username3;
  final String description3;

    Chat({
    required this.title,
    required this.username,
    required this.description,
    required this.number,
    required this.username2,
    required this.description2,
    required this.username3,
    required this.description3,
     
  });
}

class ChatContainer extends StatelessWidget {
  const ChatContainer({super.key, required this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return   Container(
       width: MediaQuery.of(context).size.width * 0.8,
      height: 260,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Row(
            children: [
              Text(
                chat.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text(
                chat.number,
                style: skyboriHintTextStyle,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.chat,
              weight: 40,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.username,
                    style: skyboriHintTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    chat.description,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.chat,
              weight: 40,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.username2,
                    style: skyboriHintTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    chat.description2,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.chat,
              weight: 40,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.username3,
                    style: skyboriHintTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    chat.description3,
                    style: TextStyle(fontSize: 14),
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