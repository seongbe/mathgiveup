import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class AnimatedPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {

  AnimatedPlayer(Vector2 position)
      : super(
          position: position,
          size: Vector2(96.0, 96.0),  // 기존 네모 크기와 동일
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
}
