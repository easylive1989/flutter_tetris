import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';

enum TetrominoType {
  i4x1,
  i1x4,
  o,
  z3x2,
  z2x3,
  s3x2,
  s2x3,
  none,
}

final Map<TetrominoType, List<Vector2>> tetrominoOffsets = {
  TetrominoType.i4x1: [Vector2(0, 20), Vector2(0, 40), Vector2(0, 60)],
  TetrominoType.i1x4: [Vector2(20, 0), Vector2(40, 0), Vector2(60, 0)],
};

TetrominoType getType(List<Domino> dominoes) {
  var offsets = dominoes
      .sublist(1, 4)
      .map((domino) => domino.position - dominoes[0].position);

  for (var entry in tetrominoOffsets.entries) {
    if (const UnorderedIterableEquality().equals(entry.value, offsets)) {
      return entry.key;
    }
  }
  return TetrominoType.none;
}

void updateOffset(TetrominoType type, List<Domino> dominoes) {
  for (int index = 1; index < 4; index++) {
    dominoes[index].position =
        dominoes[0].position + tetrominoOffsets[type]![index - 1];
  }
}
