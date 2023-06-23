import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/domino_board.dart';
import 'package:flutter_tetris/game/domino_generator.dart';
import 'package:mocktail/mocktail.dart';

main() {
  testWithGame(
    "2 x 1 domino should stop when reach the bottom",
    () => FlameGame(),
    (game) async {
      var dominoBoard = DominoBoard(TetrominoOGenerator());
      await game.ensureAdd(dominoBoard);
      await dominoBoard.ensureAdd(Domino(position: Vector2(0, 0)));
      await dominoBoard.ensureAdd(Domino(position: Vector2(0, 20)));

      game.update(17);
      game.update(1);
      game.update(1);

      var dominoes = getDominoes(dominoBoard);
      expect(dominoes[0].position.y, 360);
      expect(dominoes[1].position.y, 380);
    },
  );

  testWithGame(
    "squad domino should stop when reach the bottom",
    () => FlameGame(),
    (game) async {
      var dominoBoard = DominoBoard(TetrominoOGenerator());
      await game.ensureAdd(dominoBoard);
      await dominoBoard.ensureAdd(Domino(position: Vector2(0, 0)));
      await dominoBoard.ensureAdd(Domino(position: Vector2(0, 20)));
      await dominoBoard.ensureAdd(Domino(position: Vector2(20, 0)));
      await dominoBoard.ensureAdd(Domino(position: Vector2(20, 20)));

      game.update(17);
      game.update(1);
      game.update(1);

      var dominoes = getDominoes(dominoBoard);
      expect(dominoes[0].position.y, 360);
      expect(dominoes[1].position.y, 380);
      expect(dominoes[2].position.y, 360);
      expect(dominoes[3].position.y, 380);
    },
  );

  testWithGame(
    "domino should rotate when press key up",
    () => FlameGame(),
    (game) async {
      var dominoBoard = DominoBoard(TetrominoIGenerator());
      await game.ensureAdd(dominoBoard);

      game.update(10);
      dominoBoard.onKeyEvent(MockRawKeyEvent(), {
        LogicalKeyboardKey.arrowUp,
      });

      var dominoes = getDominoes(dominoBoard);
      expect(dominoes[0].position, Vector2(0, 200));
      expect(dominoes[1].position, Vector2(20, 200));
      expect(dominoes[2].position, Vector2(40, 200));
      expect(dominoes[3].position, Vector2(60, 200));
    },
  );
}

List<Domino> getDominoes(DominoBoard board) =>
    board.children.whereType<Domino>().toList();

class FakeGame extends FlameGame {
  @override
  Future onLoad() async {
    super.onLoad();
  }
}

class MockRawKeyEvent extends Mock implements RawKeyEvent {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
}
