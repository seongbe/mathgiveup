import 'package:flame/components.dart';

class GameTimer extends TextComponent {
  double remainingTime;
  GameTimer(this.remainingTime);

  @override
  void update(double dt) {
    remainingTime -= dt;
    if (remainingTime <= 0) {
      // 게임 오버 로직
      removeFromParent();
    }
    text = "Time: ${remainingTime.toStringAsFixed(1)}";
  }
}
