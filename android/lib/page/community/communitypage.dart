import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/community/postpage.dart';
import 'package:mathgame/page/community/writepage.dart';
import 'package:mathgame/page/community/postlistpage.dart';
import 'dart:convert';

class Communitypage extends StatefulWidget {
  @override
  State<Communitypage> createState() => _CommunitypageState();
}

class _CommunitypageState extends State<Communitypage> {
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
     
    // 다른 공지사항들을 필요에 따라 추가할 수 있습니다.
  ];

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
              ...communitys.asMap().entries.map((entry) {
                int index = entry.key;
                Community community = entry.value;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Get.to(() =>
                              Postlistpage()); // 첫 번째 컨테이너 클릭 시 Postpage로 이동
                        } else if (index == 1) {
                          Get.to(() =>
                              Postpage()); // 두 번째 컨테이너 클릭 시 Friendpage로 이동
                        }
                        // 추가적인 인덱스에 대한 동작을 여기에 추가할 수 있습니다.
                      },
                      child: CommunityContainer(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 240,
                        community: community,
                      ),
                    ),
                    if (index == 0) // 첫 번째 컨테이너인지 확인
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.to(() => Writepage());
                            },
                            child: Text('글쓰기'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(() => Postlistpage());
                            },
                            child: Text('글목록'),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                );
              }).toList(),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '학교랭킹',
                    style: skyboriTextStyle.copyWith(fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RankingContainer(),
                    ],
                  ),
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

  CommunityContainer({
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
              SizedBox(
                width: 120,
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

class Chat {
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
  ChatContainer({super.key, required this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icon(
                Icons.chat,
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
              Icon(
                Icons.chat,
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
              Icon(
                Icons.chat,
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
class RankingContainer extends StatefulWidget {
  const RankingContainer({Key? key}) : super(key: key);

  @override
  _RankingContainerState createState() => _RankingContainerState();
}
class _RankingContainerState extends State<RankingContainer> {
  Future<List<String>> fetchSchools() async {
    final response = await http.get(Uri.parse(
        'https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=a158b0dd00e34efa80c15fee4b98e98f&svcType=api&svcCode=SCHOOL&contentType=json&gubun=midd_list&region=100260'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      List<String> schoolNames = [];

      for (var school in data['dataSearch']['content']) {
        schoolNames.add(school['schoolName']);
      }
      return schoolNames;
    } else {
      throw Exception('Failed to load schools');
    }
  }

  Widget _buildRankRow({required String medal, required String schoolName, required String stage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          medal,
          style: TextStyle(fontSize: 25),
        ),
        Text(
          schoolName,
          style: TextStyle(fontSize: 25),
        ),
        Text(
          stage,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: FutureBuilder<List<String>>(
        future: fetchSchools(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('학교 목록을 불러오는 중 오류가 발생했습니다.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('학교 목록을 찾을 수 없습니다.'));
          } else {
            // null이 아님이 확실하므로 `!` 없이 사용 가능합니다.
            final schoolNames = snapshot.data!.take(3).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRankRow(medal: '🥇', schoolName: schoolNames[0], stage: '30점'),
                SizedBox(height: 5),
                _buildRankRow(medal: '🥈', schoolName: schoolNames[1], stage: '20점'),
                SizedBox(height: 5),
                _buildRankRow(medal: '🥉', schoolName: schoolNames[2], stage: '10점'),
              ],
            );
          }
        },
      ),
    );
  }
}
