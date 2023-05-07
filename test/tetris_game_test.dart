import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

main() {
  testWithGame(
    "Game start",
    () => TetrisGame(),
    (game) async {
      game.update(10);

      expect(lastDomino(game).position.y, 200);
      expect(game.score, 1);
    },
  );

  testWithGame(
    "Domino stop when it reaches the bottom",
    () => TetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);

      expect(firstDomino(game).position.y, 380);
      expect(game.score, 2);
    },
  );

  testWithGame(
    "Show another falling domino when pre domino stop",
    () => TetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);
      game.update(1);

      expect(domino(game).length, 2);
    },
  );

  testWithGame(
    "Show another falling domino when pre domino stop",
    () => TetrisGame(),
    (game) async {
      game.update(19);

      game.update(1);

      expect(domino(game).length, 2);
      expect(lastDomino(game).position.y, 20);

      game.update(17);

      expect(lastDomino(game).position.y, 360);

      game.update(1);

      expect(domino(game).length, 3);
      expect(lastDomino(game).position.y, 20);
    },
  );

  testWithGame(
    "Game over",
    () {
      var tetrisGame = TetrisGame();
      tetrisGame.overlays.addEntry("gameOver", (context, game) => SizedBox());
      return tetrisGame;
    },
    (game) async {
      for (var i = 19; i >= 0; i--) {
        game.update(i.toDouble());
      }

      expect(game.dominoSlots[0][0], true);
      expect(game.isGameOver, true);
    },
  );
}

Domino firstDomino(TetrisGame game) =>
    domino(game).first;

Iterable<Domino> domino(TetrisGame game) => game.children.whereType<Domino>();

Domino lastDomino(TetrisGame game) =>
    domino(game).last;
