import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/domino_generator.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

main() {
  final flameTester = FlameTester(() {
    return TetrisGame(dominoGenerator: TetrominoOGenerator());
  });

  flameTester.testGameWidget(
    "Move domino to right",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(10);

      await pressKey(tester, game, LogicalKeyboardKey.arrowRight, 1);

      game.update(1);

      expect(domino(game).first.position.x, 20);
    },
  );

  flameTester.testGameWidget(
    "Second domino should reach the bottom when it moves to another column",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(18);
      game.update(1);
      game.update(10);

      await pressKey(tester, game, LogicalKeyboardKey.arrowRight, 1);

      game.update(8);
      game.update(1);

      expect(stopDomino(game)[4].position.y, 360);
    },
  );

  flameTester.testGameWidget(
    "Domino can't move less than 0 column",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(10);

      await pressKey(tester, game, LogicalKeyboardKey.arrowLeft, 1);

      expect(domino(game).first.position.x, 0);
    },
  );

  flameTester.testGameWidget(
    "Domino can't move large than 9 column",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(10);

      await pressKey(tester, game, LogicalKeyboardKey.arrowRight, 12);

      expect(domino(game).first.position.x, 180);
    },
  );

  flameTester.testGameWidget(
    "Eliminate domino when domino stop in one row",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(18);
      game.update(0);
      game.update(16);
      game.update(0);

      for (var i = 1; i < 5; i++) {
        game.update(10);
        await pressKey(tester, game, LogicalKeyboardKey.arrowRight, i);
        game.update(8);
        game.update(0);
      }

      game.update(0);
      expect(domino(game).length, 8);
      expect(domino(game).first.position, Vector2(0, 360));
      expect(game.score, 28);
    },
  );
}

Future<void> pressKey(
  WidgetTester tester,
  TetrisGame game,
  LogicalKeyboardKey key,
  int times,
) async {
  for (var i = 0; i < times; i++) {
    await tester.sendKeyEvent(key);
  }

  game.pauseEngine();
  await tester.pumpAndSettle();
  game.resumeEngine();
}

Iterable<Domino> domino(TetrisGame game) =>
    game.dominoBoard.children.whereType<Domino>();

List<Domino> stopDomino(TetrisGame game) => game.dominoBoard.children
    .whereType<Domino>()
    .where((domino) => domino.isStop)
    .toList();

class SingleDominoGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.add(Domino());
  }
}
