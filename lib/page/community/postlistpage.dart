import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/api/api_post_get.dart';
import 'package:mathgame/page/community/communitypage.dart';
import 'package:mathgame/page/community/postdetailpage.dart';

class Postlistpage extends StatelessWidget {
  const Postlistpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('게시글 목록'),
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
          FutureBuilder<List<Map<String, dynamic>>?>(
            future: getPosts(), // 게시물 목록을 가져오는 함수 호출
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('게시물이 없습니다.'));
              } else {
                List<Map<String, dynamic>> posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => PostDetailPage(post: post));
                      },
                      child: Container(
                        width: 324,
                        height: 168,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 6,
                              top: 8,
                              child: Container(
                                width: 41,
                                height: 41,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF3FAFF),
                                  shape: OvalBorder(
                                    side: BorderSide(width: 1, color: Color(0xFF86CCFD)),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    post['title']?.substring(0, 1) ?? 'T',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 57,
                              top: 17,
                              child: Text(
                                post['title'] ?? '제목 없음',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                  letterSpacing: -0.41,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 15,
                              top: 60,
                              child: Container(
                                width: 292,
                                height: 95,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    post['content'] ?? '내용 없음',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      letterSpacing: -0.41,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
