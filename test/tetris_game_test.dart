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

      expect(game.domino?.position.y, 200);
    },
  );

  testWithGame(
    "Domino stop when it reaches the bottom",
    () => TetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);

      expect(game.domino?.position.y, 380);
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

  // testWithGame(
  //   "Show another falling domino when pre domino stop",
  //   () => TetrisGame(),
  //   (game) async {
  //     game.update(19);
  //     game.update(1);
  //     game.update(1);
  //     game.update(17);
  //     game.update(1);
  //
  //     expect(game.children.length, 2);
  //     expect(_getLastDomino(game).position.y, 360);
  //   },
  // );
}

Domino _getLastDomino(TetrisGame game) => game.children.last as Domino;
