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

  void moveToNextFloor() {
    for (var domino in dominoes) {
      domino.moveToNextFloor();
    }
  }

  void rotate() {
    TType.rotate(dominoes);
    // var type = TetrominoType.from(dominoes);
    // if (type == TetrominoType.i4x1) {
    //   TType.rotate(dominoes);
    //   // TetrominoType.i1x4.apply(dominoes);
    // } else if (type == TetrominoType.i1x4) {
    //   TType.rotate(dominoes);
    //   // TetrominoType.i4x1.apply(dominoes);
    // } else if (type == TetrominoType.zHorizontal) {
    //   TetrominoType.zVertical.apply(dominoes);
    // } else if (type == TetrominoType.zVertical) {
    //   TetrominoType.zHorizontal.apply(dominoes);
    // } else if (type == TetrominoType.sHorizontal) {
    //   TetrominoType.sVertical.apply(dominoes);
    // } else if (type == TetrominoType.sVertical) {
    //   TetrominoType.sHorizontal.apply(dominoes);
    // } else if (type == TetrominoType.jUp) {
    //   TetrominoType.jRight.apply(dominoes);
    // } else if (type == TetrominoType.jRight) {
    //   TetrominoType.jDown.apply(dominoes);
    // } else if (type == TetrominoType.jDown) {
    //   TetrominoType.jLeft.apply(dominoes);
    // } else if (type == TetrominoType.jLeft) {
    //   TetrominoType.jUp.apply(dominoes);
    // } else if (type == TetrominoType.lUp) {
    //   TetrominoType.lLeft.apply(dominoes);
    // } else if (type == TetrominoType.lLeft) {
    //   TetrominoType.lDown.apply(dominoes);
    // } else if (type == TetrominoType.lDown) {
    //   TetrominoType.lRight.apply(dominoes);
    // } else if (type == TetrominoType.lRight) {
    //   TetrominoType.lUp.apply(dominoes);
    // } else if (type == TetrominoType.tUp) {
    //   TetrominoType.tRight.apply(dominoes);
    // } else if (type == TetrominoType.tRight) {
    //   TetrominoType.tDown.apply(dominoes);
    // } else if (type == TetrominoType.tDown) {
    //   TetrominoType.tLeft.apply(dominoes);
    // } else if (type == TetrominoType.tLeft) {
    //   TetrominoType.tUp.apply(dominoes);
    // }

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
