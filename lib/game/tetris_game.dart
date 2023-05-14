import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tetris/game/domino_manger.dart';
import 'package:flutter_tetris/game/score.dart';

class TetrisGame extends FlameGame {
  bool isGameOver = false;
  DominoManager? _dominoManager;

  DominoManager get dominoManager => _dominoManager!;

  int get score => _dominoManager?.dominoCount ?? 0;

  @override
  Future onLoad() async {
    super.onLoad();

    add(_dominoManager = DominoManager());
    add(Score(margin: const EdgeInsets.only(top: 10, left: 200)));
  }

  Future restart() async {
    overlays.remove(overlays.activeOverlays.first);
    removeAll(children.whereType<DominoManager>());
    add(_dominoManager = DominoManager());
    isGameOver = false;
    resumeEngine();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) {
      overlays.add('gameOver');
      pauseEngine();
    }
  }
}
