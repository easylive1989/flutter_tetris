import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/src/game/notifying_vector2.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'dart:math';

import 'package:flutter_tetris/game/tetromino_offsets.dart';

class Tetromino {
  final List<Domino> dominoes;

  Tetromino(this.dominoes);

  bool get isRightOfBoundary =>
      dominoes.every((domino) => domino.isRightOfBoundary);

  bool isRightOf(Iterable<Domino> otherDominoes) =>
      dominoes.any((domino) => domino.isRightOf(otherDominoes));

  bool get isLeftOfBoundary =>
      dominoes.every((domino) => domino.isLeftOfBoundary);

  bool isLeftOf(Iterable<Domino> otherDominoes) =>
      dominoes.any((domino) => domino.isLeftOf(otherDominoes));

  bool isTopOf(Iterable<Domino> otherDominoes) =>
      dominoes.any((domino) => domino.isTopOf(otherDominoes));

  bool get isLastFloor => dominoes.any((domino) => domino.isLastFloor);

  void stop() {
    for (var domino in dominoes) {
      domino.stop();
    }
  }

  void moveRight() {
    for (var domino in dominoes) {
      domino.moveRight();
    }
  }

  void moveLeft() {
    for (var domino in dominoes) {
      domino.moveLeft();
    }
  }

  void rotate() {
    var floorGroup = groupBy(dominoes, (domino) => domino.floor);
    var columnGroup = groupBy(dominoes, (domino) => domino.column);
    bool isZ =
        dominoes.elementAt(0).position.x < dominoes.elementAt(3).position.x;
    var type = getType(dominoes);
    if (type == TetrominoType.i4x1) {
      updateOffset(TetrominoType.i1x4, dominoes);
    } else if (type == TetrominoType.i1x4) {
      updateOffset(TetrominoType.i4x1, dominoes);
    } else if (floorGroup.length == 2 && columnGroup.length == 3 && isZ) {
      var dp = dominoes.elementAt(0).position;
      dominoes.elementAt(1).position = Vector2(dp.x, dp.y + 20);
      dominoes.elementAt(2).position = Vector2(dp.x - 20, dp.y + 20);
      dominoes.elementAt(3).position = Vector2(dp.x - 20, dp.y + 40);
    } else if (floorGroup.length == 3 && columnGroup.length == 2 && !isZ) {
      var dp = dominoes.elementAt(0).position;
      dominoes.elementAt(1).position = Vector2(dp.x + 20, dp.y);
      dominoes.elementAt(2).position = Vector2(dp.x + 20, dp.y + 20);
      dominoes.elementAt(3).position = Vector2(dp.x + 40, dp.y + 20);
    } else if (floorGroup.length == 2 && columnGroup.length == 3 && !isZ) {
      var dp = dominoes.elementAt(0).position;
      dominoes.elementAt(1).position = Vector2(dp.x, dp.y + 20);
      dominoes.elementAt(2).position = Vector2(dp.x + 20, dp.y + 20);
      dominoes.elementAt(3).position = Vector2(dp.x + 20, dp.y + 40);
    } else if (floorGroup.length == 3 && columnGroup.length == 2 && isZ) {
      var dp = dominoes.elementAt(0).position;
      dominoes.elementAt(1).position = Vector2(dp.x - 20, dp.y);
      dominoes.elementAt(2).position = Vector2(dp.x - 20, dp.y + 20);
      dominoes.elementAt(3).position = Vector2(dp.x - 40, dp.y + 20);
    }

    _adjustIfOutOfRightBoundary();

    _adjustIfOutOfLeftBoundary();
  }

  void _adjustIfOutOfLeftBoundary() {
    var rowDiffWithBoundary =
        dominoes.map((domino) => 0 - domino.position.x).reduce(max);
    if (rowDiffWithBoundary > 0) {
      for (var domino in dominoes) {
        domino.position.x += rowDiffWithBoundary;
      }
    }
  }

  void _adjustIfOutOfRightBoundary() {
    var rowDiffWithBoundary =
        dominoes.map((domino) => domino.position.x - 180).reduce(max);
    if (rowDiffWithBoundary > 0) {
      for (var domino in dominoes) {
        domino.position.x -= rowDiffWithBoundary;
      }
    }
  }
}
