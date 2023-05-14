import 'dart:ui';

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

      await tester.tapAt(Offset.zero);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);

      game.pauseEngine();
      await tester.pumpAndSettle();
      game.resumeEngine();

      game.update(1);

      expect(domino(game).last.position.x, 20);
    },
    skip: true,
  );
}

Iterable<Domino> domino(TetrisGame game) => game.dominoManager.children.whereType<Domino>();
