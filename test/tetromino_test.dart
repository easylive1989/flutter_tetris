import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino_generator.dart';
import 'package:flutter_tetris/game/tetromino.dart';

main() {
  test("rotate O tetromino should keep same style", () {
    var tetromino = Tetromino(TetrominoOGenerator().getDominoes());

    tetromino.rotate();

    expect(tetromino.dominoes.map((domino) => domino.position), [
      Vector2(0, 0),
      Vector2(0, 20),
      Vector2(20, 0),
      Vector2(20, 20),
    ]);
  });

  group("rotate I tetromino", (){
    test("rotate 4 x 1 tetromino should be 1 x 4 tetromino", () {
      var tetromino = Tetromino(TetrominoIGenerator().getDominoes());

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(0, 0),
        Vector2(20, 0),
        Vector2(40, 0),
        Vector2(60, 0),
      ]);
    });

    test("rotate 1 x 4 tetromino should be 4 x 1 tetromino", () {
      var tetromino = Tetromino(TetrominoIGenerator().getDominoes());

      tetromino.rotate();
      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(0, 0),
        Vector2(0, 20),
        Vector2(0, 40),
        Vector2(0, 60),
      ]);
    });
  });

}
