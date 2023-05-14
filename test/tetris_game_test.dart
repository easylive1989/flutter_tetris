import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

main() {
  testWithGame(
    "Game start",
    () => createTetrisGame(),
    (game) async {
      game.update(10);

      expect(domino(game).last.position.y, 200);
      expect(game.score, 1);
    },
  );

  testWithGame(
    "Domino stop when it reaches the bottom",
    () => createTetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);

      expect(domino(game).first.position.y, 380);
      expect(game.score, 2);
    },
  );

  testWithGame(
    "Show another falling domino when pre domino stop",
    () => createTetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);
      game.update(1);

      expect(domino(game).length, 2);
    },
  );

  testWithGame(
    "Domino stop when it reaches another domino",
    () => createTetrisGame(),
    (game) async {
      game.update(19);
      game.update(1);
      game.update(18);
      game.update(1);


      expect(domino(game).elementAt(1).position.y, 360);
    },
  );

  testWithGame(
    "Game over",
    () => createTetrisGame(),
    (game) async {
      waitForGameOver(game);

      expect(game.dominoManager.dominoSlots[0][0], true);
      expect(game.isGameOver, true);
    },
  );

  testWithGame(
    "Restart game",
    () => createTetrisGame(),
    (game) async {
      waitForGameOver(game);

      await game.restart();
      game.update(0);

      expect(domino(game).length, 1);
      expect(game.isGameOver, false);
    },
  );
}

void waitForGameOver(TetrisGame game) {
  for (var i = 19; i >= 0; i--) {
    game.update(i.toDouble());
    game.update(1);
  }
}

TetrisGame createTetrisGame() {
  var tetrisGame = TetrisGame();
  tetrisGame.overlays.addEntry("gameOver", (context, game) {
    return const SizedBox();
  });
  return tetrisGame;
}

Iterable<Domino> domino(TetrisGame game) => game.dominoManager.children.whereType<Domino>();
