import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: TetrisGame(),
          overlayBuilderMap: {
            'gameOver': (BuildContext context, TetrisGame game) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Game Over',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              );
            },
          },
        ),
      ),
    );
  }
}
