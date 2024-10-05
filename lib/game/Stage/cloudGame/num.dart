import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/painting.dart'; // 색상을 사용하기 위한 패키지
import 'dart:math';
import 'package:mathgame/const/styles.dart';

class Num extends TextComponent with HasGameRef {
  final Random _random = Random();
  int num = 0;
  int numType = 0; // 1: 소수, 2: 소수가 아닌 수

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    num = _random.nextInt(99) + 2;
    text = num.toString(); // 숫자를 텍스트로 변환하여 표시
    numType = checkPrimeNum();

    // 글씨 색상 검은색으로 설정
    textRenderer = TextPaint(
      style: TextStyle(
        fontFamily: 'Skybori',
        color: Color(0xFF000000), // 검은색으로 설정
        fontSize: 24, // 글씨 크기 조절 가능
      ),
    );

    // 위치 설정
    if (position.y == 0 && position.x == 0) {
      position = Vector2(
        _random.nextDouble() * (gameRef.size.x - size.x),
        gameRef.camera.viewfinder.position.y - _random.nextDouble() * 100,
      );
    }
    //print('Num class num: ${num}, numType: ${numType}');
  }

  @override
  void update(double dt) {
    // 숫자 이동 로직 (아래에서 위로 이동)
    position.y += 100 * dt; // 속도 조절 가능
    if (position.y > gameRef.size.y) {
      removeFromParent(); // 화면 밖으로 나가면 제거
    }

    // numType 값이 정상적으로 유지되는지 확인
    //print('Update 중 numType: $numType');
  }

  // 소수 확인
  int checkPrimeNum() {
    if (num < 2) {
      return 2;
    }
    for (int i = 2; i <= num ~/ 2; i++) {
      if (num % i == 0) {
        return 2;
      }
    }
    return 1;
  }
}
