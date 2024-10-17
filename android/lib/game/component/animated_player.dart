import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/game/GamePage4.dart';

class AnimatedPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<MathGame> {

  AnimatedPlayer(Vector2 position)
      : super(
          position: position,
          size: Vector2(96.0, 96.0),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'animated_player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.5,
        textureSize: Vector2(16, 16),
      ),
    );
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 조이패드 입력에 따라 캐릭터 이동
    if (gameRef.joystick.direction != Vector2.zero()) {
      position.add(gameRef.joystick.relativeDelta * 200 * dt);  // 속도 조절
     scale.x = gameRef.joystick.relativeDelta.x < 0 ? -1 : 1;
    }
  }
}

class MyGame extends FlameGame with HasCollisionDetection {
  late AnimatedPlayer _player;
  late JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 조이패드 설정
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: Paint()..color = Colors.blue),
      background: CircleComponent(radius: 50, paint: Paint()..color = Colors.grey.withOpacity(0.5)),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    // 플레이어 추가
    _player = AnimatedPlayer(Vector2(size.x / 2, size.y / 2));
    add(_player);
    add(joystick);
  }
}
