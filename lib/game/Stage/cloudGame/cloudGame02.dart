import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/camera.dart';
import 'package:flame/src/experimental/geometry/shapes/shape.dart';
import 'package:flame/src/experimental/geometry/shapes/rectangle.dart';
import 'package:mathgame/const/colors.dart';
import 'package:mathgame/game/Stage/cloudGame/num.dart';
import 'dart:ui';
import 'cloud.dart';
import 'player.dart';
import 'dart:math';

class CloudGame02 extends FlameGame with HasCollisionDetection, TapDetector {
  late Player player;
  final Random _random = Random();
  double _cloudTimer = 0.0;
  List<Cloud> cloudList = [];
  List<Num> numList = [];

  @override
  Color backgroundColor() {
    return BACKGROUND_COLOR; // 원하는 배경색 설정
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 플레이어 추가
    player = Player();
    await world.add(player);

    // 충돌 처리 시스템 추가
    await world.add(ScreenHitbox());

    // 초기 구름 배치
    startCloud();

    //카메라 설정
    setCamera();
  }

  void setCamera() {
    print("카메라 설정 시작");
    // size 값이 올바른지 확인
    print("size: ${size.x}, ${size.y}");
    print("Player: ${player}");
    // 카메라 설정
    camera.follow(
      this.player,
      horizontalOnly: false, // 수평 방향으로는 따라가지 않음
      verticalOnly: true, // 수직 방향으로만 따라감
      snap: true, // 즉시 플레이어 위치로 이동
    );

    // 하단 경계 설정
    var rectangle = Rectangle.fromLTRB(
      0,
      -double.infinity,
      size.x,
      size.y / 2,
    );

    // 카메라 경계 설정: 카메라가 하단으로 더 이상 내려가지 않도록 제한
    camera.setBounds(
      rectangle, // Rectangle 경계를 설정
      considerViewport: true, // 뷰포트 전체가 경계를 넘지 않도록 설정
    );
    print("카메라 설정 완료");
  }

  @override
  void onTapDown(TapDownInfo info) {
    // 터치 위치에 따라 플레이어 이동
    if (info.eventPosition.widget.x < size.x / 2) {
      player.moveLeft();
    } else {
      player.moveRight();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 일정 시간마다 구름 생성
    _cloudTimer += dt;
    if (_cloudTimer > 2) {
      _cloudTimer = 0.0;
      int cloudType = 1;
      //int cloudType = _random.nextBool() ? 1 : 2;
      for (int i = 0; i < 5; i++) {
        Cloud cloud = Cloud(cloudType);
        cloud.position = Vector2(i * 80.0, size.y / 2);
        world.add(cloud);
        cloudList.add(cloud);

        Num _num = Num();
        _num.position = cloud.position + Vector2(25, 20);
        print('num: ${_num.num}, numType: ${_num.numType}');
        world.add(_num);
        numList.add(_num);
      }
    }

    // 캐릭터가 화면 아래로 떨어지면 게임 종료
    if (player.position.y > size.y) {
      gameOver();
    }
  }

  void startCloud() {
    print("구름 초기화 시작");
    // 초기 구름 5개 하단에 배치
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 3; j++) {
        int cloudType = _random.nextBool() ? 1 : 2;
        Cloud cloud = Cloud(cloudType);
        //print(cloud.position);

        // 구름을 하단에 배치하도록 position을 설정
        cloud.position = Vector2(
          i * 80.0,
          size.y - (j * 150),
        );

        world.add(cloud); // 구름을 월드에 추가
        cloudList.add(cloud); // 구름을 리스트에 추가
        //print(cloud.position);
      }
    }
    print("구름 초기화 완료");
  }

  void gameOver() {
    overlays.add('GameOverMenu');
    pauseEngine();
  }

  void reset() {
    player.position = Vector2(size.x / 2, size.y - 100);
    player.velocity = Vector2.zero();
    camera.moveTo(player.position); // 카메라를 플레이어 위치로 이동
    camera.follow(player); // 카메라가 플레이어를 따라가도록 설정
    // world에서 구름 제거
    for (var cloud in cloudList) {
      if (cloud.parent != null) {
        world.remove(cloud);
      }
    }
    cloudList.clear(); // 구름 리스트 비움
    startCloud();
    //setCamera();
  }
}
