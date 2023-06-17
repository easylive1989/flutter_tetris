import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';

abstract class DominoGenerator {
  void generate(Component board);
}

class SquadDominoGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.add(Domino(position: Vector2(0, 0)));
    board.add(Domino(position: Vector2(0, 20)));
    board.add(Domino(position: Vector2(20, 0)));
    board.add(Domino(position: Vector2(20, 20)));
  }
}