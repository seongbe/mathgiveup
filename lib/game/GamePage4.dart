import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/animated_player.dart';

class GamePage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame Demo',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScoreController scoreController = Get.put(ScoreController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Game Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              return Text(
                'Score: ${scoreController.score.value}',
                style: TextStyle(fontSize: 20),
              );
            }),
          ),
        ],
      ),
      body: GameWidget(
        game: MathGame(),
      ),
    );
  }
}

class ScoreController extends GetxController {
  var score = 0.obs;

  void increaseScore() {
    score.value++;
  }
}

class MathGame extends FlameGame with HasCollisionDetection, TapCallbacks {
  late AnimatedPlayer player;
  late SpriteComponent background;
  late JoystickComponent joystick;
  double nextSpawnSeconds = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();


    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: Paint()..color = Colors.blue),
      background: CircleComponent(radius: 50, paint: Paint()..color = Colors.grey.withOpacity(0.5)),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    add(joystick);

    background = SpriteComponent()
      ..sprite = await loadSprite('background.png')
      ..size = size;
    add(background);

    player = AnimatedPlayer(
      Vector2(size.x * 0.25, size.y - 25),
    );
    add(player);

    Get.put(ScoreController());
  }

  @override
  void update(double dt) {
    super.update(dt);
    nextSpawnSeconds -= dt;
    if (nextSpawnSeconds < 0) {
      // 정답 문제 생성
      String correctProblem = _generateMathProblem();
      int correctAnswer = _calculateAnswer(correctProblem);

      // 오답 문제 생성 (정답과 다른 값으로 설정)
      String incorrectProblem = _generateMathProblem();
      int incorrectAnswer = correctAnswer + (Random().nextBool() ? 1 : -1);

      add(Star(
        Vector2(size.x * 0.25, 0),
        correctProblem,
        correctAnswer,
        isCorrect: true,
      ));

      add(Star(
        Vector2(size.x * 0.75, 0),
        incorrectProblem,
        incorrectAnswer,
        isCorrect: false,
      ));

      nextSpawnSeconds = 0.3 + Random().nextDouble() * 2;
    }
  }

  String _generateMathProblem() {
    final random = Random();
    final operation = random.nextInt(4);
    int a, b;
    String problem = "";

    switch (operation) {
      case 0:
        a = random.nextInt(100) + 1;
        b = random.nextInt(100) + 1;
        problem = "$a + $b";
        break;
      case 1:
        a = random.nextInt(100) + 1;
        b = random.nextInt(100) + 1;
        if (a < b) {
          final temp = a;
          a = b;
          b = temp;
        }
        problem = "$a - $b";
        break;
      case 2:
        a = random.nextInt(12) + 1;
        b = random.nextInt(12) + 1;
        problem = "$a × $b";
        break;
      case 3:
        b = random.nextInt(12) + 1;
        a = b * (random.nextInt(12) + 1);
        problem = "$a ÷ $b";
        break;
    }
    return problem;
  }

  int _calculateAnswer(String problem) {
    final parts = problem.split(' ');
    final a = int.parse(parts[0]);
    final operator = parts[1];
    final b = int.parse(parts[2]);

    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return a ~/ b;
      default:
        throw Exception('Unknown operator');
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      if (touchPoint.x > size.x / 2) {
        player.position = Vector2(size.x * 0.75, size.y - 20);
      } else {
        player.position = Vector2(size.x * 0.25, size.y - 20);
      }
    }
  }
}

class Star extends RectangleComponent with HasGameRef, CollisionCallbacks {
  static const starSize = 80.0;
  late TextComponent problemTextComponent;
  late TextComponent answerTextComponent;
  final String problem;
  final int correctAnswer;
  final bool isCorrect;

  Star(Vector2 position, this.problem, this.correctAnswer, {required this.isCorrect})
      : super(
          position: position,
          size: Vector2.all(starSize),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.yellow;
    add(RectangleHitbox());

    problemTextComponent = TextComponent(
      text: problem,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      anchor: Anchor.center,
      position: Vector2(starSize / 2, starSize / 3),
    );

    answerTextComponent = TextComponent(
      text: correctAnswer.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.red),
      ),
      anchor: Anchor.center,
      position: Vector2(starSize / 2, 2 * starSize / 3),
    );

    add(problemTextComponent);
    add(answerTextComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 5;
    if (position.y - starSize > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is AnimatedPlayer) {
      // 정답이 맞는 별과 충돌했을 때만 점수 증가
      if (isCorrect) {
        Get.find<ScoreController>().increaseScore();
      }
      removeFromParent();
    } else {
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}
