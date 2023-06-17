import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/domino_board.dart';

abstract class DominoGenerator {
  void generate(DominoBoard board);
}

class SquadDominoGenerator extends DominoGenerator {
  @override
  void generate(DominoBoard board) {
    board.add(Domino(position: Vector2(0, 0)));
    board.add(Domino(position: Vector2(0, 20)));
    board.add(Domino(position: Vector2(20, 0)));
    board.add(Domino(position: Vector2(20, 20)));
  }
}