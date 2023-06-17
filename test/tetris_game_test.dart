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

      expect(movingDominoes(game).first.position.y, 200);
      expect(game.score, 4);
    },
  );

  testWithGame(
    "Domino stop when it reaches the bottom",
    () => createTetrisGame(),
    (game) async {
      game.update(18);
      game.update(1);
      game.update(1);

      expect(stopDominoes(game).first.position.y, 360);
    },
  );

  testWithGame(
    "Show another falling domino when pre domino stop",
    () => createTetrisGame(),
    (game) async {
      game.update(18);
      game.update(1);
      game.update(1);

      expect(dominoes(game).length, 8);
    },
  );

  testWithGame(
    "Domino stop when it reaches another domino",
    () => createTetrisGame(),
    (game) async {
      game.update(18);
      game.update(1);
      game.update(16);
      game.update(1);

      expect(stopDominoes(game)[4].position.y, 320);
    },
  );

  testWithGame(
    "Game over",
    () => createTetrisGame(),
    (game) async {
      waitForGameOver(game);

      expect(game.dominoBoard.isDominoReachTop, true);
    },
  );

  testWithGame(
    "Restart game",
    () => createTetrisGame(),
    (game) async {
      waitForGameOver(game);

      await game.restart();
      game.update(0);

      expect(movingDominoes(game).length, 4);
      expect(game.dominoBoard.isDominoReachTop, false);
    },
  );
}

void waitForGameOver(TetrisGame game) {
  for (var i = 19; i >= 0; i--) {
    game.update(i.toDouble());
    game.update(0);
  }
}

TetrisGame createTetrisGame() {
  var tetrisGame = TetrisGame();
  tetrisGame.overlays.addEntry("gameOver", (context, game) {
    return const SizedBox();
  });
  return tetrisGame;
}

Iterable<Domino> movingDominoes(TetrisGame game) => game.dominoBoard.children
    .whereType<Domino>()
    .where((element) => !element.isStop);

List<Domino> stopDominoes(TetrisGame game) => game.dominoBoard.children
    .whereType<Domino>()
    .where((element) => element.isStop).toList();

Iterable<Domino> dominoes(TetrisGame game) => game.dominoBoard.children
    .whereType<Domino>();
