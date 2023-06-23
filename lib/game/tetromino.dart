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
    var type = getType(dominoes);
    if (type == TetrominoType.i4x1) {
      updateOffset(TetrominoType.i1x4, dominoes);
    } else if (type == TetrominoType.i1x4) {
      updateOffset(TetrominoType.i4x1, dominoes);
    } else if (type == TetrominoType.zHorizontal) {
      updateOffset(TetrominoType.zVertical, dominoes);
    } else if (type == TetrominoType.zVertical) {
      updateOffset(TetrominoType.zHorizontal, dominoes);
    } else if (type == TetrominoType.sHorizontal) {
      updateOffset(TetrominoType.sVertical, dominoes);
    } else if (type == TetrominoType.sVertical) {
      updateOffset(TetrominoType.sHorizontal, dominoes);
    } else if (type == TetrominoType.jUp) {
      updateOffset(TetrominoType.jRight, dominoes);
    } else if (type == TetrominoType.jRight) {
      updateOffset(TetrominoType.jDown, dominoes);
    } else if (type ==TetrominoType.jDown) {
      updateOffset(TetrominoType.jLeft, dominoes);
    } else if (type == TetrominoType.jLeft) {
      updateOffset(TetrominoType.jUp, dominoes);
    } else if (type == TetrominoType.lUp) {
      updateOffset(TetrominoType.lLeft, dominoes);
    } else if (type == TetrominoType.lLeft) {
      updateOffset(TetrominoType.lDown, dominoes);
    } else if (type == TetrominoType.lDown) {
      updateOffset(TetrominoType.lRight, dominoes);
    } else if (type == TetrominoType.lRight) {
      updateOffset(TetrominoType.lUp, dominoes);
    } else if (type == TetrominoType.tUp) {
      updateOffset(TetrominoType.tRight, dominoes);
    } else if (type == TetrominoType.tRight) {
      updateOffset(TetrominoType.tDown, dominoes);
    } else if (type == TetrominoType.tDown) {
      updateOffset(TetrominoType.tLeft, dominoes);
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
