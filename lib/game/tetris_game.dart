import 'package:flame/game.dart';
import 'package:flutter_tetris/game/domino.dart';

class TetrisGame extends FlameGame {

  final List<List<bool>> dominoSlots = List.generate(
    21,
    (i) {
      return List.generate(10, (j) {
        return i == 20;
      }, growable: false);
    },
    growable: false
  );

  @override
  Future onLoad() async {
    super.onLoad();

    add(Domino());
  }
}
