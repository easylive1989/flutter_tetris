import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetromino_offsets.dart';

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
      ...tetrominoOffsets[TetrominoType.o]!
          .map((offset) => Domino(position: offset)),
    ]);
  }
}

class TetrominoIGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
      Domino(position: Vector2(0, 0)),
      ...tetrominoOffsets[TetrominoType.i4x1]!
          .map((offset) => Domino(position: offset)),
    ]);
  }
}

class TetrominoJGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
      Domino(position: Vector2(0, 0)),
      ...tetrominoOffsets[TetrominoType.jUp]!
          .map((offset) => Domino(position: offset)),
    ]);
  }
}

class TetrominoLGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
      Domino(position: Vector2(0, 0)),
      ...tetrominoOffsets[TetrominoType.lUp]!
          .map((offset) => Domino(position: offset)),
    ]);
  }
}

class TetrominoSGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
      Domino(position: Vector2(0, 0)),
      ...tetrominoOffsets[TetrominoType.sHorizontal]!
          .map((offset) => Domino(position: offset)),
    ]);
  }
}

class TetrominoTGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
      Domino(position: Vector2(0, 0)),
      ...tetrominoOffsets[TetrominoType.tUp]!
          .map((offset) => Domino(position: offset)),
    ]);
  }
}

class TetrominoZGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll([
      Domino(position: Vector2(0, 0)),
      ...tetrominoOffsets[TetrominoType.zHorizontal]!
          .map((offset) => Domino(position: offset)),
    ]);
  }
}
