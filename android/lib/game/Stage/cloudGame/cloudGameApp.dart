import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:mathgame/const/styles.dart';
import 'package:mathgame/game/Stage/cloudGame/cloudGame.dart';

class CloudGameApp extends StatelessWidget {
  final VoidCallback? onStageCompleted;
  final CloudGame _game = CloudGame();

  CloudGameApp({this.onStageCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(title: '스테이지 1'),
        body: GameWidget<CloudGame>(
          game: _game,
          overlayBuilderMap: {
            'GameOverMenu': (BuildContext context, CloudGame game) {
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
