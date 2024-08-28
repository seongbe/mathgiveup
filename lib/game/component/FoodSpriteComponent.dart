import 'dart:math'; // Random을 사용하기 위해 추가
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
 
import 'package:mathgame/game/GamePage5.dart';


class FoodSpriteComponent extends SpriteComponent with CollisionCallbacks, HasGameRef {
  static const int gridRows = 8;
  static const int gridCols = 8;
  final Random _random = Random(); // Random 객체 생성

  FoodSpriteComponent({Vector2? position})
      : super(
          size: Vector2(32.0, 32.0), // 음식 아이템 크기
          position: position ?? Vector2.zero(),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final spriteSheet = await gameRef.loadSprite('Food.png');

    // 랜덤으로 하나의 음식 선택
    final int row = _random.nextInt(gridRows);
    final int col = _random.nextInt(gridCols);

    sprite = Sprite(
      spriteSheet.image,
      srcSize: Vector2(16.0, 16.0), // 각 음식의 크기
      srcPosition: Vector2(col * 16.0, row * 16.0), // 해당 음식의 위치
    );

    add(RectangleHitbox());

     
  }

  

  @override
 void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  if (other is AnimatedPlayer) {
    print("Player collided with food.");
    removeFromParent(); // 아이템 제거
    gameRef.removeFood(); // 음식 제거 및 새로운 음식 생성 요청
  }
  super.onCollision(intersectionPoints, other);
}
}

extension on FlameGame<World> {
  void removeFood() {}
}
