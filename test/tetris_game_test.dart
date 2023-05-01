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
      game.update(30);

      expect(game.domino?.position.y, 570);
    },
  );
}
