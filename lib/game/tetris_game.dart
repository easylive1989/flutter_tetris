import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/score.dart';

class TetrisGame extends FlameGame {
  List<List<bool>> dominoSlots = List.generate(21, (i) {
    return List.generate(10, (j) {
      return i == 20;
    }, growable: false);
  }, growable: false);

  int score = 1;
  bool isGameOver = false;

  @override
  Future onLoad() async {
    super.onLoad();

    add(Domino());
    add(Score(margin: const EdgeInsets.only(top: 10, left: 200)));
  }

  Future restart() async {
    overlays.remove(overlays.activeOverlays.first);
    removeAll(children.whereType<Domino>());
    dominoSlots = List.generate(21, (i) {
      return List.generate(10, (j) {
        return i == 20;
      }, growable: false);
    }, growable: false);
    await add(Domino());
    score = 1;
    resumeEngine();
  }
}
