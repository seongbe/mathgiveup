import 'dart:math';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:mathgame/game/component/FoodSpriteComponent.dart';

class Gamepage5 extends StatefulWidget {
  const Gamepage5({super.key});

  @override
  _Gamepage5State createState() => _Gamepage5State();
}

class _Gamepage5State extends State<Gamepage5> {
  int score = 0;
  late BackgroundGame game;

  void incrementScore() {
    setState(() {
      score++;
    });
  }

  @override
  void initState() {
    super.initState();
    game = BackgroundGame(onFoodEaten: (foodPosition) {
      showCoordinateInputDialog(foodPosition, (isCorrect) {
        if (isCorrect) {
          incrementScore();
        }
      });
    });
  }
void showCoordinateInputDialog(Vector2 foodPosition, Function(bool) onAnswerChecked) {
    final xController = TextEditingController();
    final yController = TextEditingController();
    const double gridSize = 50.0;

    final screenSize = game.size;

    // 화면 중앙을 기준으로 수학적 좌표로 변환
    final centerX = screenSize.x / 2;
    final centerY = screenSize.y / 2;

    // 수학적 좌표계로 변환 (화면의 중심을 (0,0)으로)
    final mathX = ((foodPosition.x - centerX) / gridSize).round();
    final mathY = ((centerY - foodPosition.y) / gridSize).round(); // Y 좌표의 방향 반전

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter the coordinates of the food'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: xController,
                decoration: InputDecoration(labelText: 'X coordinate'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: yController,
                decoration: InputDecoration(labelText: 'Y coordinate'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Text(
                'Correct answer: X = $mathX, Y = $mathY',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final inputX = int.tryParse(xController.text);
                final inputY = int.tryParse(yController.text);

                if (inputX != null && inputY != null) {
                  final isCorrect = (inputX == mathX) && (inputY == mathY);
                  onAnswerChecked(isCorrect);
                }
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Game Page - Score: $score'),
      ),
      body: Stack(
        children: [
          GameWidget(
            game: game,
          ),
        ],
      ),
    );
  }
}

class BackgroundGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  late AnimatedPlayer _player;
  late JoystickComponent joystick;
  FoodSpriteComponent? _currentFood;
  final Function(Vector2) onFoodEaten;

  BackgroundGame({required this.onFoodEaten});

  final double gridSize = 50.0;  // 그리드의 크기

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final background = SpriteComponent()
      ..sprite = await loadSprite('background.png')
      ..size = size;
    add(background);

    add(CoordinateGrid());

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: Paint()..color = Colors.blue),
      background: CircleComponent(radius: 50, paint: Paint()..color = Colors.grey.withOpacity(0.5)),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    add(joystick);

    _player = AnimatedPlayer(Vector2(size.x / 2, size.y / 2));
    add(_player);

    _spawnFood();
  }

  void _spawnFood() {
    if (_currentFood == null) {
        final random = Random();
        Vector2 foodPosition;

        do {
            foodPosition = Vector2(
                (random.nextInt((size.x ~/ gridSize)) * gridSize).toDouble(),
                (random.nextInt((size.y ~/ gridSize)) * gridSize).toDouble(),
            );
        } while (_player.position.distanceTo(foodPosition) < 64.0);

        foodPosition.x = (foodPosition.x / gridSize).round() * gridSize;
        foodPosition.y = (foodPosition.y / gridSize).round() * gridSize;

        _currentFood = FoodSpriteComponent(position: foodPosition);
        add(_currentFood!);
    }
}

  Vector2 convertToMathCoordinates(Vector2 screenPosition) {
    final centerX = size.x / 2;
    final centerY = size.y / 2;

    final mathX = ((screenPosition.x - centerX) / gridSize).round();
    final mathY = ((centerY - screenPosition.y) / gridSize).round(); // Y 좌표 방향 그대로 유지

    return Vector2(mathX.toDouble(), mathY.toDouble());
  }

  void removeFood() {
    if (_currentFood != null) {
      final foodPosition = _currentFood!.position;
      _currentFood!.removeFromParent();
      _currentFood = null;

      final mathCoordinates = convertToMathCoordinates(foodPosition);
      onFoodEaten(mathCoordinates);
      
      _spawnFood();
    }
  }
}

class CoordinateGrid extends Component with HasGameRef<BackgroundGame> {
  static const double _gridSize = 50.0;
  static const double _offset = 12.0;

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = BasicPalette.white.color
      ..strokeWidth = 1.0;

    final screenWidth = gameRef.size.x;
    final screenHeight = gameRef.size.y;

    final centerX = screenWidth / 2;
    final centerY = screenHeight / 2;

    for (double y = 0; y < screenHeight + _offset; y += _gridSize) {
      canvas.drawLine(Offset(-_offset, y + _offset), Offset(screenWidth, y + _offset), paint);
    }

    for (double x = 0; x < screenWidth + _offset; x += _gridSize) {
      canvas.drawLine(Offset(x + _offset, -_offset), Offset(x + _offset, screenHeight), paint);
    }

    paint.color = BasicPalette.black.color;
    paint.strokeWidth = 2.0;

    canvas.drawLine(Offset(centerX, 0), Offset(centerX, screenHeight), paint);
    canvas.drawLine(Offset(0, centerY), Offset(screenWidth, centerY), paint);

    _drawAxisLabels(canvas, centerX, centerY, Size(screenWidth, screenHeight));
  }

  void _drawAxisLabels(Canvas canvas, double centerX, double centerY, Size screenSize) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = -5; i <= 5; i++) {
      if (i == 0) continue;

      final labelText = i.toString();
      final textSpan = TextSpan(
        text: labelText,
        style: TextStyle(color: Colors.black, fontSize: 14),
      );

      textPainter.text = textSpan;
      textPainter.layout();

      final dx = centerX + i * _gridSize - (textPainter.width / 2);
      final dy = centerY + 5;

      textPainter.paint(canvas, Offset(dx, dy));
    }

    for (int i = -7; i <= 7; i++) {
      if (i == 0) continue;

      final labelText = i.toString();
      final textSpan = TextSpan(
        text: labelText,
        style: TextStyle(color: Colors.black, fontSize: 14),
      );

      textPainter.text = textSpan;
      textPainter.layout();

      final dx = centerX - textPainter.width - 5;
      final dy = centerY - i * _gridSize - (textPainter.height / 2);

      textPainter.paint(canvas, Offset(dx, dy));
    }

    final xLabel = TextSpan(
      text: 'X',
      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    );
    textPainter.text = xLabel;
    textPainter.layout();
    textPainter.paint(canvas, Offset(screenSize.width - textPainter.width - 0, centerY + 20));

    final yLabel = TextSpan(
      text: 'Y',
      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    );
    textPainter.text = yLabel;
    textPainter.layout();
    textPainter.paint(canvas, Offset(centerX + 5, 10));
  }
}

class AnimatedPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<BackgroundGame> {

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

    if (gameRef.joystick.direction != Vector2.zero()) {
      position.add(gameRef.joystick.relativeDelta * 200 * dt);
      scale.x = gameRef.joystick.relativeDelta.x < 0 ? -1 : 1;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if (other is FoodSpriteComponent) {
      gameRef.removeFood();
    }
  }
}
