import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tetris/game/domino.dart';

abstract class DominoGenerator {
  void generate(Component board);
}

class RandomTetrominoGenerator extends DominoGenerator {
  final TetrominoOGenerator oGenerator = TetrominoOGenerator();
  final TetrominoIGenerator iGenerator = TetrominoIGenerator();
  final TetrominoTGenerator tGenerator = TetrominoTGenerator();
  final TetrominoSGenerator sGenerator = TetrominoSGenerator();
  final TetrominoZGenerator zGenerator = TetrominoZGenerator();
  final TetrominoJGenerator jGenerator = TetrominoJGenerator();
  final TetrominoLGenerator lGenerator = TetrominoLGenerator();

  @override
  void generate(Component board) {
    final randomInt = Random().nextInt(7);
    return {
      0: oGenerator,
      1: iGenerator,
      2: tGenerator,
      3: sGenerator,
      4: zGenerator,
      5: jGenerator,
      6: lGenerator,
    }[randomInt]!
        .generate(board);
  }
}

class TetrominoOGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
        Domino(position: Vector2(0, 0)),
        Domino(position: Vector2(0, 20)),
        Domino(position: Vector2(20, 0)),
        Domino(position: Vector2(20, 20)),
      ]);
  }
}

class TetrominoIGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
      Domino(position: Vector2(0, 0)),
      Domino(position: Vector2(0, 20)),
      Domino(position: Vector2(0, 40)),
      Domino(position: Vector2(0, 60)),
    ]);
  }
}

class TetrominoJGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.add(Domino(position: Vector2(0, 0)));
    board.add(Domino(position: Vector2(0, 20)));
    board.add(Domino(position: Vector2(20, 20)));
    board.add(Domino(position: Vector2(40, 20)));
  }
}

class TetrominoLGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.add(Domino(position: Vector2(40, 0)));
    board.add(Domino(position: Vector2(0, 20)));
    board.add(Domino(position: Vector2(20, 20)));
    board.add(Domino(position: Vector2(40, 20)));
  }
}

class TetrominoSGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.add(Domino(position: Vector2(20, 0)));
    board.add(Domino(position: Vector2(40, 0)));
    board.add(Domino(position: Vector2(0, 20)));
    board.add(Domino(position: Vector2(20, 20)));
  }
}

class TetrominoTGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.add(Domino(position: Vector2(20, 0)));
    board.add(Domino(position: Vector2(0, 20)));
    board.add(Domino(position: Vector2(20, 20)));
    board.add(Domino(position: Vector2(40, 20)));
  }
}

class TetrominoZGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.add(Domino(position: Vector2(0, 0)));
    board.add(Domino(position: Vector2(20, 0)));
    board.add(Domino(position: Vector2(20, 20)));
    board.add(Domino(position: Vector2(40, 20)));
  }
}
