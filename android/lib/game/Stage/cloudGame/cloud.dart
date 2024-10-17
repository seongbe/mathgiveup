import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'dart:math';

class Cloud extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Cloud(this.type);

  final int type; // 1: cloud.png, 2: cloud2.png
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    String imageName = type == 1 ? 'cloud.png' : 'cloud2.png';
    sprite = await gameRef.loadSprite(imageName);
    size = Vector2(80, 80); // 구름 크기 설정

    if (position.y == 0 && position.x == 0) {
      position = Vector2(
        _random.nextDouble() * (gameRef.size.x - size.x),
        gameRef.camera.viewfinder.position.y - _random.nextDouble() * 100,
      );
    }
    // 구름의 히트박스 추가 (크기를 70%로 줄임)
    final hitbox = RectangleHitbox.relative(
      Vector2(0.7, 0.7), // 너비와 높이를 70%로 설정
      parentSize: size, // 구름 크기 기준
    );
    add(hitbox);
  }

  @override
  void update(double dt) {
    // 구름 이동 로직 (아래에서 위로 이동)
    position.y += 100 * dt; // 속도 조절 가능
    if (position.y > gameRef.size.y) {
      removeFromParent(); // 화면 밖으로 나가면 제거
    }
  }
}
