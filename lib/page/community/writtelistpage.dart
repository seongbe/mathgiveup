import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';

class Writelistpage extends StatelessWidget {
  const Writelistpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigator.pop 대신 Get.back을 사용하여 뒤로가기
          },
        ),
        title: Text('게시글'),
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
          Align(
             alignment: Alignment.topCenter, 
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  
                  width: 337,
                  height: 500,
                  padding: EdgeInsets.all(20.0), // 내부 여백 설정
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                      Text(
                        '닉네임',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: '제목',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
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
                       
                    ],
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    
    );
  }
}