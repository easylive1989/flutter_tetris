import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetromino/tetromino_typ_group_impl.dart';

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
    board.addAll(
      OTypeGroup.o.offsets
          .map((offset) => Domino(position: offset, color: Colors.yellow)),
    );
  }
}

class TetrominoIGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll(
      ITypeGroup.i4x1.offsets
          .map((offset) => Domino(position: offset, color: Colors.cyanAccent)),
    );
  }
}

class TetrominoJGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll(
      JTypeGroup.jUp.offsets
          .map((offset) => Domino(position: offset, color: Colors.indigo)),
    );
  }
}

class TetrominoLGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll(
      LTypeGroup.lUp.offsets
          .map((offset) => Domino(position: offset, color: Colors.orange)),
    );
  }
}

class TetrominoSGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll(
      STypeGroup.sVertical.offsets
          .map((offset) => Domino(position: offset, color: Colors.green)),
    );
  }
}

class TetrominoTGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll(
      TTypeGroup.tDown.offsets
          .map((offset) => Domino(position: offset, color: Colors.purple)),
    );
  }
}

class TetrominoZGenerator extends DominoGenerator {
  @override
  void generate(Component board) {
    board.addAll(
      ZTypeGroup.zVertical.offsets
          .map((offset) => Domino(position: offset, color: Colors.red)),
    );
  }
}
