import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

main() {
  testWithGame(
    "Game start",
    () => TetrisGame(),
    (game) async {
      game.update(10);

      expect(game.domino?.position.y, 300);
    },
  );

  testWithGame(
    "Domino stop when it reaches the bottom",
    () => TetrisGame(),
    (game) async {
      game.update(19);
      game.update(20);

      expect(game.domino?.position.y, 570);
    },
  );

  testWithGame(
    "Show another falling domino when pre domino stop",
    () => TetrisGame(),
    (game) async {
      game.update(19);
      game.update(20);
      game.update(21);

      expect(game.children.length, 2);
    },
  );
}
