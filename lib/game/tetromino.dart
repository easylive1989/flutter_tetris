import 'package:flutter_tetris/game/domino.dart';
import 'dart:math';

import 'package:flutter_tetris/game/tetromino/tetromino_type_group.dart';

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
    TetrominoTypeGroup.rotate(dominoes);

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
