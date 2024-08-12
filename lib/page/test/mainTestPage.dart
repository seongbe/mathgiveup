import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/test/grade1_02.dart';
import 'package:mathgame/page/test/testCode.dart';
import 'package:mathgame/page/test/testCode02.dart';

class MainTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '실력테스트'),
      body: BackgroundContainer(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            MyWidget(),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 185),
        Container(
          width: 310,
          height: 277,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/실력테스트.png"),
            ),
          ),
        ),
        SizedBox(height: 70),
        Container(
          width: 288,
          height: 60,
          child: CustomButton(
            text: '시작하기',
            onPressed: () {
              Get.to(Grade1_02());
            },
          ),
        ),
      ],
    );
  }
}
