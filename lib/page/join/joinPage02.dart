import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/page/find/popUpPage.dart';
import 'package:mathgame/page/test/mainTestPage.dart';

class JoinPage02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
      appBar: AppBar(
        title: Text('회원가입'),
      ),
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
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  String idErrorMessage = '';
  String passworddErrorMessage = '';
  String nicknameErrorMessage = '';
  String brithErrorMessage = '';
  String gradeErrorMessage = '';
  Color idErrorColor = Colors.red;
  Color nicknameErrorColor = Colors.red;
  bool isIdVerified = false; // 아이디 중복확인 여부를 추적하는 변수
  bool isNicknameVerified = false; // 닉네임 중복확인 여부를 추적하는 변수
  int selectedButtonIndex = -1; // 선택된 버튼의 인덱스를 추적

  void _checkId() {
    setState(() {
      if (idController.text.isEmpty) {
        idErrorMessage = '아이디를 입력해 주세요.';
        idErrorColor = Colors.red;
        isIdVerified = false;
      } else if (existingIds.contains(idController.text.trim())) {
        idErrorMessage = '이미 사용 중인 아이디입니다.';
        idErrorColor = Colors.red;
        isIdVerified = false;
      } else {
        idErrorMessage = '사용 가능한 아이디입니다.';
        idErrorColor = Colors.blue;
        isIdVerified = true;
      }
    });
  }

  void _checkNickname() {
    setState(() {
      if (nicknameController.text.isEmpty) {
        nicknameErrorMessage = '닉네임을 입력해 주세요.';
        nicknameErrorColor = Colors.red;
        isNicknameVerified = false;
      } else if (existingNicknames.contains(nicknameController.text.trim())) {
        nicknameErrorMessage = '이미 사용 중인 닉네임입니다.';
        nicknameErrorColor = Colors.red;
        isNicknameVerified = false;
      } else {
        nicknameErrorMessage = '사용 가능한 닉네임입니다.';
        nicknameErrorColor = Colors.blue;
        isNicknameVerified = true;
      }
    });
  }

  void _checkField() {
    setState(() {
      if (idController.text.isEmpty) {
        // 아이디 입력 안 한 경우
        idErrorMessage = '아이디를 입력해 주세요.';
        idErrorColor = Colors.red;
        isIdVerified = false;
      } else if (isIdVerified == false) {
        // 중복 검사를 안 한 경우
        idErrorMessage = '아이디 중복 검사를 해주세요';
      } else if (passwordController.text.isEmpty ||
          checkPasswordController.text.isEmpty) {
        // 비번 입력을 안 한 경우
        passworddErrorMessage = '비밀번호를 입력해주세요.';
      } else if (passwordController.text != checkPasswordController.text) {
        // 비번이 틀린 경우
        passworddErrorMessage = '비밀번호를 다시 확인해주세요.';
      } else if (nicknameController.text.isEmpty) {
        // 닉네임 입력을 안 한 경우
        nicknameErrorMessage = '닉네임을 입력해 주세요.';
        nicknameErrorColor = Colors.red;
        isNicknameVerified = false;
        passworddErrorMessage = '';
      } else if (isNicknameVerified == false) {
        // 중복 검사를 안 한 경우
        nicknameErrorMessage = '닉네임 중복 검사를 해주세요';
      } else if (birthController.text.isEmpty) {
        brithErrorMessage = '생일을 입력해 주세요.';
      } else if (selectedButtonIndex == -1) {
        gradeErrorMessage = '학년을 선택해 주세요.';
        brithErrorMessage = '';
      } else {
        Get.to(PopUpPage(
          message: '회원가입이 완료되었습니다.\n확인 버튼을 누르면 실력테스트로 넘어갑니다.',
          onPressed: () {
            Get.to(MainTestPage());
          },
        ));
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        // DateFormat을 사용하여 날짜를 로컬 형식으로 변환
        birthController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputField(
            label: '아이디',
            controller: idController,
            hintText: '아이디 입력(n ~ m자)',
            errorMessage: idErrorMessage,
            errorColor: idErrorColor,
            button: CustomButton(
              text: '중복확인',
              fontSize: 20,
              onPressed: _checkId,
            ),
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '비밀번호',
            controller: passwordController,
            hintText: '숫자, 영문, 특수문자 조합 8자 이상',
            errorMessage: passworddErrorMessage,
            obscureText: true,
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '비밀번호 확인',
            controller: checkPasswordController,
            hintText: '비밀번호 한 번 더 입력',
            errorMessage: '', // 이 필드에는 에러 메시지가 없으므로 빈 문자열 전달
            obscureText: true,
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '닉네임',
            controller: nicknameController,
            hintText: '닉네임 입력',
            errorMessage: nicknameErrorMessage,
            errorColor: nicknameErrorColor,
            button: CustomButton(
              text: '중복확인',
              fontSize: 20,
              onPressed: _checkNickname,
            ),
          ),
          SizedBox(height: 20),
          CustomInputField(
            label: '생년월일',
            controller: birthController,
            hintText: '생년월일을 선택하세요',
            errorMessage: brithErrorMessage,
            onTap: () => _selectDate(context),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                '학년 선택',
                style: skyboriBaseTextStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
              if (gradeErrorMessage.isNotEmpty)
                Text(
                  gradeErrorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomSelectableButton(
                text: '1학년',
                isSelected: selectedButtonIndex == 1,
                onPressed: () {
                  setState(() {
                    selectedButtonIndex = 1;
                  });
                },
              ),
              CustomSelectableButton(
                text: '2학년',
                isSelected: selectedButtonIndex == 2,
                onPressed: () {
                  setState(() {
                    selectedButtonIndex = 2;
                  });
                },
              ),
              CustomSelectableButton(
                text: '3학년',
                isSelected: selectedButtonIndex == 3,
                onPressed: () {
                  setState(() {
                    selectedButtonIndex = 3;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 288,
                height: 60,
                child: CustomButton(
                  text: '가입하기',
                  onPressed: _checkField,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
