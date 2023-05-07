import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/score.dart';

class TetrisGame extends FlameGame {
  final List<List<bool>> dominoSlots = List.generate(21, (i) {
    return List.generate(10, (j) {
      return i == 20;
    }, growable: false);
  }, growable: false);

  int score = 1;

  @override
  Future onLoad() async {
    super.onLoad();

    add(Domino());
    add(Score(margin: const EdgeInsets.only(top: 10, left: 10)));
  }
}
