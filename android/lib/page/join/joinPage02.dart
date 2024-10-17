import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/page/join/joinProcess.dart';

class JoinPage02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: CustomAppBar(title: '회원가입'),
      body: ListView(
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  late JoinProcess joinProcess;

  @override
  void initState() {
    super.initState();
    joinProcess = JoinProcess(
      nameController: nameController,
      idController: idController,
      passwordController: passwordController,
      checkPasswordController: checkPasswordController,
      nicknameController: nicknameController,
      birthController: birthController,
    );
    joinProcess.initEmail(Get.arguments as String);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          CustomInputField(
            label: '이름',
            controller: nameController,
            hintText: '이름 입력',
            errorMessage: '',
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '아이디',
            controller: idController,
            hintText: '아이디 입력(4 ~ 12자)',
            errorMessage: joinProcess.idErrorMessage,
            errorColor: joinProcess.idErrorColor,
            button: CustomButton(
              text: '중복확인',
              fontSize: 20,
              onPressed: () {
                joinProcess.checkID(existingIds, this);
              },
            ),
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '비밀번호',
            controller: passwordController,
            hintText: '대소문자, 숫자, 특수문자 조합 8자 이상',
            errorMessage: '',
            obscureText: true,
          ),
          SizedBox(height: 10),
          CustomTextField(
            controller: checkPasswordController,
            hintText: '비밀번호 한 번 더 입력',
            obscureText: true,
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '닉네임',
            controller: nicknameController,
            hintText: '닉네임 입력',
            errorMessage: '',
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '생년월일',
            controller: birthController,
            hintText: '생년월일을 선택하세요',
            errorMessage: '',
            onTap: () {
              joinProcess.selectDate(context, this);
            },
          ),
          SizedBox(height: 20),
          Text(
            '학년 선택',
            style: skyboriBaseTextStyle.copyWith(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(joinProcess.grades.length, (index) {
              return CustomSelectableButton(
                text: joinProcess.grades[index],
                isSelected: joinProcess.selectedButtonIndex == index + 1,
                onPressed: () {
                  setState(() {
                    joinProcess.selectedButtonIndex = index + 1;
                  });
                },
              );
            }),
          ),
          SizedBox(height: 30),
          Center(
            child: Container(
              width: 288,
              height: 60,
              child: CustomButton(
                text: '가입하기',
                onPressed: () {
                  joinProcess.checkField(context, this);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
