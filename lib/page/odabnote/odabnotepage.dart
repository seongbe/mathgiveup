import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/controller/NavigationController.dart';
import 'package:mathgame/page/odabnote/detailnotepage.dart';

class Odabnotepage extends StatelessWidget {
  const Odabnotepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> noteDates = [
      "05/20 MON",
      "05/21 TUE",
      "05/22 WED",
      "05/23 THU",
      "05/24 FRI",
    ];

    final NavigationController navigationController = Get.find();

    return Scaffold(
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
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      '2024',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: noteDates.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Notebutton(
                        width: 400,
                        height: 70,
                        text: noteDates[index],
                        onPressed: () {
                             Get.to(() => DetailNotepage());
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Notebutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const Notebutton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.black, width: 2), // 테두리 색상 및 두께
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        minimumSize: Size(width ?? 100.0, height ?? 50.0),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: skyboriBaseTextStyle.copyWith(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
