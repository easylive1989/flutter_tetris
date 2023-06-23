import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetromino.dart';

main() {
  test("rotate O tetromino should keep same style", () {
    var tetromino = Tetromino([
      Domino(position: Vector2(0, 0)),
      Domino(position: Vector2(0, 20)),
      Domino(position: Vector2(20, 0)),
      Domino(position: Vector2(20, 20)),
    ]);

    tetromino.rotate();

    expect(tetromino.dominoes.map((domino) => domino.position), [
      Vector2(0, 0),
      Vector2(0, 20),
      Vector2(20, 0),
      Vector2(20, 20),
    ]);
  });

  group("rotate I tetromino", () {
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

    test("rotate 4 x 1 tetromino at right boundary", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(180, 0)),
        Domino(position: Vector2(180, 20)),
        Domino(position: Vector2(180, 40)),
        Domino(position: Vector2(180, 60)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(120, 0),
        Vector2(140, 0),
        Vector2(160, 0),
        Vector2(180, 0),
      ]);
    });

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

  group("rotate Z tetromino", () {
    test("rotate horizontal Z", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(40, 20)),
        Domino(position: Vector2(60, 20)),
        Domino(position: Vector2(60, 40)),
        Domino(position: Vector2(80, 40)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(40, 20),
        Vector2(40, 40),
        Vector2(20, 40),
        Vector2(20, 60),
      ]);
    });

    test("rotate Z at left boundary", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(0, 20)),
        Domino(position: Vector2(20, 20)),
        Domino(position: Vector2(20, 40)),
        Domino(position: Vector2(40, 40)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(20, 20),
        Vector2(20, 40),
        Vector2(0, 40),
        Vector2(0, 60),
      ]);
    });

    test("rotate vertical Z", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(40, 20)),
        Domino(position: Vector2(40, 40)),
        Domino(position: Vector2(20, 40)),
        Domino(position: Vector2(20, 60)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(40, 20),
        Vector2(60, 20),
        Vector2(60, 40),
        Vector2(80, 40),
      ]);
    });
  });

  group("rotate S tetromino", () {
    test("rotate horizontal S", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(60, 20)),
        Domino(position: Vector2(60, 40)),
        Domino(position: Vector2(40, 40)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(80, 40),
        Vector2(100, 40),
        Vector2(100, 60),
      ]);
    });

    test("rotate vertical S", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(80, 40)),
        Domino(position: Vector2(100, 40)),
        Domino(position: Vector2(100, 60)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(60, 20),
        Vector2(60, 40),
        Vector2(40, 40),
      ]);
    });
  });

  group("rotate J", () {
    test("rotate J up", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(100, 20)),
        Domino(position: Vector2(120, 20)),
        Domino(position: Vector2(120, 40)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(80, 40),
        Vector2(80, 60),
        Vector2(60, 60),
      ]);
    });

    test("rotate J right", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(80, 40)),
        Domino(position: Vector2(80, 60)),
        Domino(position: Vector2(60, 60)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(80, 40),
        Vector2(100, 40),
        Vector2(120, 40),
      ]);
    });

    test("rotate J Down", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(80, 40)),
        Domino(position: Vector2(100, 40)),
        Domino(position: Vector2(120, 40)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(100, 20),
        Vector2(80, 40),
        Vector2(80, 60),
      ]);
    });

    test("rotate J Left", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(100, 20)),
        Domino(position: Vector2(80, 40)),
        Domino(position: Vector2(80, 60)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(100, 20),
        Vector2(120, 20),
        Vector2(120, 40),
      ]);
    });
  });

  group("rotate L", () {
    test("rotate L Up", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(100, 20)),
        Domino(position: Vector2(120, 20)),
        Domino(position: Vector2(80, 40)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(100, 20),
        Vector2(100, 40),
        Vector2(100, 60),
      ]);
    });

    test("rotate L Left", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(100, 20)),
        Domino(position: Vector2(100, 40)),
        Domino(position: Vector2(100, 60)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(80, 40),
        Vector2(60, 40),
        Vector2(40, 40),
      ]);
    });

    test("rotate L Down", () {
      var tetromino = Tetromino([
        Domino(position: Vector2(80, 20)),
        Domino(position: Vector2(80, 40)),
        Domino(position: Vector2(60, 40)),
        Domino(position: Vector2(40, 40)),
      ]);

      tetromino.rotate();

      expect(tetromino.dominoes.map((domino) => domino.position), [
        Vector2(80, 20),
        Vector2(80, 40),
        Vector2(80, 60),
        Vector2(100, 60),
      ]);
    });
  });

}
