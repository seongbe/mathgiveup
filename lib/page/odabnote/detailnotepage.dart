 import 'package:flutter/material.dart';
import 'package:mathgame/const/styles.dart';


class DetailNotepage extends StatelessWidget {
  const DetailNotepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Smath',
        style: skyboriBaseTextStyle,),
        
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
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '01.',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                       Container(
                      
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 500,
                     
                    decoration: BoxDecoration(
                      image: DecorationImage(
                       image: AssetImage('assets/images/mathgame1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('마지막 접속: 5일전',
                  style: skyboriHintTextStyle.copyWith(fontSize: 15),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                     onPressed: (){
                      },
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.black, width: 2), // 테두리 색상 및 두께
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(30),
                     ),
                 backgroundColor: Colors.white,
      ),
      child: Text(
        "다음문제 >",
        textAlign: TextAlign.center,
        style: skyboriBaseTextStyle.copyWith(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    ),
                    ],
                  ),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      
    );
  }
}

  