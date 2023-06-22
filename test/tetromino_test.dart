import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino_generator.dart';
import 'package:flutter_tetris/game/tetromino.dart';

main() {
  test("rotate O tetromino should keep same style", () {
    var tetrominoOGenerator = TetrominoOGenerator();

    var tetromino = Tetromino(tetrominoOGenerator.getODominoes());

    tetromino.rotate();

    expect(tetromino.dominoes.map((domino) => domino.position), [
      Vector2(0, 0),
      Vector2(0, 20),
      Vector2(20, 0),
      Vector2(20, 20),
    ]);
  });
}
