import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart'; // 스프라이트 애니메이션
import 'dart:math';

class Gamepage6 extends StatefulWidget {
  const Gamepage6({super.key});

  @override
  State<Gamepage6> createState() => _Gamepage6State();
}

class _Gamepage6State extends State<Gamepage6> {
  late SimpleGame game;

  @override
  void initState() {
    super.initState();
    game = SimpleGame(); // 게임 인스턴스 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // 뒤로 가기
          },
        ),
        title: Text('Game Page'),
      ),
      body: GameWidget(game: game), // 게임 화면을 표시
    );
  }
}

class SimpleGame extends FlameGame with HasCollisionDetection {
  late Player player;
  late JoystickComponent joystick; // 조이스틱 컴포넌트 선언
  FoodSpriteComponent? _currentFood;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 배경 추가
    final background = SpriteComponent()
      ..sprite = await loadSprite('background.png') // 배경 이미지 로드
      ..size = size;
    add(background);

    // 조이스틱 추가
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: Paint()..color = Colors.blue),
      background: CircleComponent(radius: 50, paint: Paint()..color = Colors.grey.withOpacity(0.5)),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick); // 조이스틱을 게임에 추가

    // 화면 중앙에 플레이어 추가
    player = Player(position: size / 2);
    add(player);

    // 음식 생성
    _spawnFood();
  }

  void _spawnFood() {
    final random = Random();
    Vector2 foodPosition = Vector2(
      random.nextDouble() * size.x,
      random.nextDouble() * size.y,
    );

    _currentFood = FoodSpriteComponent(position: foodPosition);
    add(_currentFood!);
  }

  void removeFood() {
    if (_currentFood != null) {
      _currentFood!.removeFromParent(); // 음식 제거
      _currentFood = null;
      _spawnFood(); // 새로운 음식 생성
    }
  }
}

class Player extends SpriteAnimationComponent with HasGameRef<SimpleGame>, CollisionCallbacks {
  Player({required Vector2 position})
      : super(position: position, size: Vector2(96, 96), anchor: Anchor.center);

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

    // 조이스틱을 사용한 플레이어 이동
    if (gameRef.joystick.direction != Vector2.zero()) {
      position.add(gameRef.joystick.relativeDelta * 200 * dt); // 조이스틱의 상대 이동값에 따라 플레이어 이동
      // 플레이어 방향 변경
      scale.x = gameRef.joystick.relativeDelta.x < 0 ? -1 : 1;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is FoodSpriteComponent) {
      gameRef.removeFood(); // 플레이어가 음식과 충돌하면 음식 제거
    }
  }
}

class FoodSpriteComponent extends SpriteComponent with CollisionCallbacks {
  FoodSpriteComponent({required Vector2 position})
      : super(position: position, size: Vector2(50, 50), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('food.png'); // 음식 이미지 로드
    add(RectangleHitbox());
    return super.onLoad();
  }
}
