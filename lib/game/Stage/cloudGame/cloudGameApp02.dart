import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/game/Stage/cloudGame/cloudGame02.dart';

class CloudGameApp02 extends StatelessWidget {
  final VoidCallback? onStageCompleted;
  final CloudGame02 _game = CloudGame02();

  CloudGameApp02({this.onStageCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(title: '스테이지 3'),
        body: GameWidget<CloudGame02>(
          game: _game,
          overlayBuilderMap: {
            'GameOverMenu': (BuildContext context, CloudGame02 game) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Game Over',
                      style: TextStyle(fontSize: 48, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        game.resumeEngine();
                        game.overlays.remove('GameOverMenu');
                        game.reset();
                      },
                      child: Text('Restart'),
                    ),
                  ],
                ),
              );
            },
          },
          initialActiveOverlays: const [],
        ),
      ),
    );
  }
}
