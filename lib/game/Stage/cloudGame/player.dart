import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:mathgame/game/Stage/cloudGame/cloud.dart';

class Player extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  final double speed = 200; // 플레이어 이동 속도
  final double gravity = 500; // 중력 가속도

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('청룡.png');
    size = Vector2(80, 92); // 캐릭터 크기 설정
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    // 플레이어의 히트박스 추가 (크기를 80%로 줄임)
    final hitbox = RectangleHitbox.relative(
      Vector2(0.8, 0.8), // 너비와 높이를 80%로 설정
      parentSize: size, // 플레이어 크기 기준
    );
    add(hitbox);
  }

  void moveLeft() {
    velocity.x = -speed;
  }

  void moveRight() {
    velocity.x = speed;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 중력 적용
    velocity.y += gravity * dt;
    position += velocity * dt;

    // 좌우 이동 후 속도 감속
    velocity.x *= 0.99;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Cloud) {
      // 구름 종류에 따른 점프 높이 설정
      double jumpVelocity = other.type == 1 ? -300 : -150;
      velocity.y = jumpVelocity;
    } else {
      velocity.y += gravity * 0.2;
    }
    super.onCollision(intersectionPoints, other);
  }
}
