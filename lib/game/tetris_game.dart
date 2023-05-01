
import 'package:flame/game.dart';
import 'package:flutter_tetris/game/domino.dart';

class TetrisGame extends FlameGame {
  @override
  Future onLoad() async {
    super.onLoad();

    var rectangleComponent = Domino();
    add(rectangleComponent);
  }
}
