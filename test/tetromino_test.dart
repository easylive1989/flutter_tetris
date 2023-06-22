import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
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
        var tetromino = Tetromino([
          Domino(position: Vector2(20, 40)),
          Domino(position: Vector2(20, 60)),
          Domino(position: Vector2(20, 80)),
          Domino(position: Vector2(20, 100)),
        ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(20, 40),
        Vector2(40, 40),
        Vector2(60, 40),
        Vector2(80, 40),
      ]);
    });

    // test("rotate 4 x 1 tetromino at right boundary", () {
    //   var tetromino = Tetromino([
    //     Domino(position: Vector2(180, 0)),
    //     Domino(position: Vector2(180, 20)),
    //     Domino(position: Vector2(180, 40)),
    //     Domino(position: Vector2(180, 60)),
    //   ]);
    //
    //
    //   tetromino.rotate();
    //
    //   expect(tetromino.dominoes.map((domino) => domino.position), [
    //     Vector2(0, 0),
    //     Vector2(0, 0),
    //     Vector2(0, 0),
    //     Vector2(0, 0),
    //   ]);
    // });

    test("rotate 1 x 4 tetromino should be 4 x 1 tetromino", () {
      var tetromino = Tetromino([
          Domino(position: Vector2(40, 20)),
          Domino(position: Vector2(60, 20)),
          Domino(position: Vector2(80, 20)),
          Domino(position: Vector2(100, 20)),
        ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(40, 20),
        Vector2(40, 40),
        Vector2(40, 60),
        Vector2(40, 80),
      ]);
    });
  });

}
