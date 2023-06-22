import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'dart:math';

class Tetromino {
  final Iterable<Domino> dominoes;

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
    if (dominoes
        .every((domino) => domino.column == dominoes.elementAt(0).column)) {
      var dp = dominoes.elementAt(0).position;
      dominoes.elementAt(1).position = Vector2(dp.x + 20, dp.y);
      dominoes.elementAt(2).position = Vector2(dp.x + 40, dp.y);
      dominoes.elementAt(3).position = Vector2(dp.x + 60, dp.y);
      return;
    }
    if (dominoes
        .every((domino) => domino.floor == dominoes.elementAt(0).floor)) {
      var dp = dominoes.elementAt(0).position;
      dominoes.elementAt(1).position = Vector2(dp.x, dp.y + 20);
      dominoes.elementAt(2).position = Vector2(dp.x, dp.y + 40);
      dominoes.elementAt(3).position = Vector2(dp.x, dp.y + 60);
    }

    // var column = dominoes.map((domino) => domino.position.x - 180).reduce(max);
    // if (column > 0) {
    //   for (var domino in dominoes) {
    //     domino.position.x -= column;
    //   }
    // }
  }
}
