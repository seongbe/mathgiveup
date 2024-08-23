import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/components.dart';

class Gamepage5 extends StatelessWidget {
  const Gamepage5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame Demo',
      home: MathMazeGame(),
    );
  }
}

class MathMazeGame extends StatelessWidget {
  const MathMazeGame({super.key});

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
        title: Text('Game Page'),
        actions: [
          Obx(() => Text('Score: ${Get.find<ScoreController>().score.value}')),
          SizedBox(width: 10),
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

class MathGame extends FlameGame {
  late Player player;
  late TextComponent problemText;
  late List<String> answers;
  int currentProblemIndex = 0;

  final List<Map<String, dynamic>> problems = [
    {"problem": "2 + 2", "answer": 4},
    {"problem": "5 - 3", "answer": 2},
    {"problem": "3 * 3", "answer": 9},
    {"problem": "8 / 4", "answer": 2},
  ];

  @override
  Future<void> onLoad() async {
    player = Player(Vector2(50, 50));
    add(player);

    problemText = TextComponent(
      text: problems[currentProblemIndex]["problem"],
      position: Vector2(100, 100),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 30, color: Colors.black),
      ),
    );
    add(problemText);

    answers = ["2", "4", "6", "8"];
    addAnswers();
  }

  void addAnswers() {
    for (int i = 0; i < answers.length; i++) {
      add(AnswerBox(Vector2(100 + i * 100, 200), answers[i], checkAnswer));
    }
  }

  void checkAnswer(String answer) {
    if (int.parse(answer) == problems[currentProblemIndex]["answer"]) {
      currentProblemIndex++;
      Get.find<ScoreController>().increaseScore();
      if (currentProblemIndex >= problems.length) {
        problemText.text = "탈출 성공!";
      } else {
        problemText.text = problems[currentProblemIndex]["problem"];
        removeAll(children.whereType<AnswerBox>().toList());
        addAnswers();
      }
    }
  }
}

class Player extends SpriteComponent {
  Player(Vector2 position)
      : super(
          position: position,
          size: Vector2(50, 50),
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('player.png');
  }
}

class AnswerBox extends TextComponent {
  final String answer;
  final Function(String) onTap;

  AnswerBox(Vector2 position, this.answer, this.onTap)
      : super(
          text: answer,
          position: position,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 30, color: Colors.blue),
          ),
        );

  @override
  bool onTapDown(TapDownInfo info) {
    onTap(answer);
    return true;
  }
}
