import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/domino_manger.dart';
import 'package:flutter_tetris/game/score.dart';

class TetrisGame extends FlameGame {
  int score = 1;
  bool isGameOver = false;
  DominoManager? _dominoManager;

  DominoManager get dominoManager => _dominoManager!;

  @override
  Future onLoad() async {
    super.onLoad();

    add(_dominoManager = DominoManager());
    add(Domino());
    add(Score(margin: const EdgeInsets.only(top: 10, left: 200)));
  }

  Future restart() async {
    overlays.remove(overlays.activeOverlays.first);
    removeAll(children.whereType<Domino>());
    removeAll(children.whereType<DominoManager>());
    await add(Domino());
    score = 1;
    resumeEngine();
  }
}
