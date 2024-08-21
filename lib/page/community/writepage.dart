import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/api/api_post.dart'; // api_post로 변경 필요
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/page/community/communitypage.dart';
import 'package:mathgame/page/community/postlistpage.dart';

class Writepage extends StatefulWidget {
  const Writepage({super.key});

  @override
  State<Writepage> createState() => _WritepageState();
}

class _WritepageState extends State<Writepage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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
        title: Text('game page'),
      ),
      body: Stack(
        children: [
          Container(
          
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'), // 배경 이미지 경로
                fit: BoxFit.cover, // 이미지 크기 조정 방식
              ),
            ),
          ),
          Center(
            child: Container(
              width: 337,
              height: 580,
              padding: EdgeInsets.all(20.0), // 내부 여백 설정
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '글 작성하기',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: '제목',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _contentController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: '내용',
                      hintText: '여기에 글을 작성하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BACKGROUND_COLOR,
                    ),
                    onPressed: () {
                      String title = _titleController.text;
                      String content = _contentController.text;

                      if (title.isNotEmpty && content.isNotEmpty) {
                        postData(title, content).then((_) {
                          Get.snackbar(
                            '성공',
                            '글이 성공적으로 작성되었습니다!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          Get.to(() => Postlistpage()); // 성공 후 뒤로가기
                        }).catchError((error) {
                          Get.snackbar(
                            '오류',
                            '글 작성 중 오류가 발생했습니다.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        });
                      } else {
                        Get.snackbar(
                          '경고',
                          '제목과 내용을 모두 입력하세요.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Text(
                      '작성 완료',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
