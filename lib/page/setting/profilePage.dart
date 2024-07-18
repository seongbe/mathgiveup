import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '프로필 변경'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          MyWidget(),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String selectedImagePath = 'assets/images/icon01.png';

  // 아이콘 선택 버튼
  Widget iconButton({required String assetPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              selectedImagePath,
              width: 120,
              height: 120,
            ),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              String assetPath =
                  'assets/images/icon${(index + 1).toString().padLeft(2, '0')}.png';
              return iconButton(
                assetPath: assetPath,
                onTap: () {
                  setState(() {
                    selectedImagePath = assetPath;
                  });
                  print('Button ${index + 1} Click');
                },
              );
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 50,
              child: CustomButton(
                text: '프로필 변경하기',
                fontSize: 25,
                onPressed: () {
                  //Get.back();
                },
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
