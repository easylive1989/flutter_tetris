import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/component/domino/domino.dart';
import 'package:flutter_tetris/game/component/domino/domino_generator.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

main() {
  final flameTester = FlameTester(() {
    return TetrisGame(dominoGenerator: TetrominoOGenerator());
  });

  flameTester.testGameWidget(
    "Move domino to left at beginning",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(0);

      await pressKey(tester, game, LogicalKeyboardKey.arrowLeft, 1);

      game.update(1);

      expect(domino(game)[0].position, Vector2(0, 20));
      expect(domino(game)[1].position, Vector2(0, 40));
      expect(domino(game)[2].position, Vector2(20, 20));
      expect(domino(game)[3].position, Vector2(20, 40));
    },
  );

  flameTester.testGameWidget(
    "Can not move the domino left when another domino is left next to it",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(0);
      game.update(18);
      game.update(0);
      game.update(10);

      await pressKey(tester, game, LogicalKeyboardKey.arrowRight, 2);

      game.update(7);

      await pressKey(tester, game, LogicalKeyboardKey.arrowLeft, 2);

      expect(domino(game)[4].position, Vector2(40, 340));
      expect(domino(game)[5].position, Vector2(40, 360));
      expect(domino(game)[6].position, Vector2(60, 340));
      expect(domino(game)[7].position, Vector2(60, 360));
    },
  );

  flameTester.testGameWidget(
    "Can move the domino left when another domino is not left next to it",
    setUp: (game, tester) async => game,
    verify: (game, tester) async {
      game.update(0);
      game.update(18);
      game.update(0);
      game.update(10);

      await pressKey(tester, game, LogicalKeyboardKey.arrowRight, 3);

      game.update(7);

      await pressKey(tester, game, LogicalKeyboardKey.arrowLeft, 1);

      expect(domino(game)[4].position, Vector2(40, 340));
      expect(domino(game)[5].position, Vector2(40, 360));
      expect(domino(game)[6].position, Vector2(60, 340));
      expect(domino(game)[7].position, Vector2(60, 360));
    },
  );

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

      expect(domino(game).first.position.x, 160);
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

List<Domino> domino(TetrisGame game) =>
    game.dominoBoard.children.whereType<Domino>().toList();

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
