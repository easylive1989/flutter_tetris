import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

main() {
  testWithGame(
    "Game start",
    () => TetrisGame(),
    (game) async {
      game.update(10);

      expect(_getLastDomino(game).position.y, 200);
    },
  );

  testWithGame(
    "Domino stop when it reaches the bottom",
    () => TetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);

      expect(_getFirstDomino(game).position.y, 380);
    },
  );

  testWithGame(
    "Show another falling domino when pre domino stop",
    () => TetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);
      game.update(1);

      expect(game.children.length, 2);
    },
  );

  testWithGame(
    "Show another falling domino when pre domino stop",
    () => TetrisGame(),
    (game) async {
      game.update(19);

      game.update(1);

      expect(game.children.length, 2);
      expect(_getLastDomino(game).position.y, 20);

      game.update(17);

      expect(_getLastDomino(game).position.y, 360);

      game.update(1);

      expect(game.children.length, 3);
      expect(_getLastDomino(game).position.y, 20);
    },
  );
}

Domino _getFirstDomino(TetrisGame game) => game.children.first as Domino;

Domino _getLastDomino(TetrisGame game) => game.children.last as Domino;
