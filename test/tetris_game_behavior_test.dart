import 'package:flame_test/flame_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

main() {
  final flameTester = FlameTester(() => TetrisGame());

  flameTester.testGameWidget(
    "Move domino to right",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(10);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);

      game.pauseEngine();
      await tester.pumpAndSettle();
      game.resumeEngine();

      game.update(1);

      expect(domino(game).first.position.x, 20);
    },
  );

  flameTester.testGameWidget(
    "Second domino should reach the bottom when it moves to another column",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(19);
      game.update(1);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);

      game.pauseEngine();
      await tester.pumpAndSettle();
      game.resumeEngine();

      game.update(18);
      game.update(1);

      expect(domino(game).elementAt(1).position.y, 380);
    },
    skip: true
  );
}

Iterable<Domino> domino(TetrisGame game) => game.dominoManager.children.whereType<Domino>();
