import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';

//  i4x1      i1x4       o   zHorizontal    zVertical    sHorizontal    sVertical
//    []    [][][][]   [][]     [][]            []          [][]          []
//    []               [][]       [][]        [][]        [][]            [][]
//    []                                      []                          []
//    []
//    jUp    jRight  jDown   jLeft   lUp    lLeft   lDown   lRight
//   [][][]    []    []       [][]  [][][]  [][]        []    []
//       []    []    [][][]   []    []        []    [][][]    []
//           [][]             []              []              [][]
//    tUp      tRight    tDown    tLeft
//     []        []      [][][]      []
//   [][][]      [][]      []      [][]
//               []                  []
enum TetrominoType {
  i4x1,
  i1x4,
  o,
  zHorizontal,
  zVertical,
  sHorizontal,
  sVertical,
  none,
  jUp,
  jRight,
  jDown,
  jLeft,
  lUp,
  lLeft,
  lDown,
  lRight,
  tUp,
  tRight,
  tDown,
  tLeft;

  void apply(List<Domino> dominoes) {
    for (int index = 0; index < 4; index++) {
      dominoes[index].position =
          dominoes[0].position + tetrominoOffsets[this]![index];
    }
  }

  static TetrominoType from(List<Domino> dominoes) {
    var offsets = dominoes.map((domino) {
      return domino.position - dominoes[0].position;
    });

    for (var entry in tetrominoOffsets.entries) {
      if (const UnorderedIterableEquality().equals(entry.value, offsets)) {
        return entry.key;
      }
    }
    return TetrominoType.none;
  }
}

final Map<TetrominoType, List<Vector2>> tetrominoOffsets = {
  TetrominoType.o: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(20, 0),
    Vector2(20, 20)
  ],
  TetrominoType.i4x1: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(0, 40),
    Vector2(0, 60)
  ],
  TetrominoType.i1x4: [
    Vector2(0, 0),
    Vector2(20, 0),
    Vector2(40, 0),
    Vector2(60, 0)
  ],
  TetrominoType.zHorizontal: [
    Vector2(0, 0),
    Vector2(20, 0),
    Vector2(20, 20),
    Vector2(40, 20)
  ],
  TetrominoType.zVertical: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(-20, 20),
    Vector2(-20, 40)
  ],
  TetrominoType.sHorizontal: [
    Vector2(0, 0),
    Vector2(-20, 0),
    Vector2(-20, 20),
    Vector2(-40, 20),
  ],
  TetrominoType.sVertical: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(20, 20),
    Vector2(20, 40)
  ],
  TetrominoType.jUp: [
    Vector2(0, 0),
    Vector2(20, 0),
    Vector2(40, 0),
    Vector2(40, 20)
  ],
  TetrominoType.jRight: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(0, 40),
    Vector2(-20, 40)
  ],
  TetrominoType.jDown: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(20, 20),
    Vector2(40, 20)
  ],
  TetrominoType.jLeft: [
    Vector2(0, 0),
    Vector2(20, 0),
    Vector2(0, 20),
    Vector2(0, 40)
  ],
  TetrominoType.lUp: [
    Vector2(0, 0),
    Vector2(20, 0),
    Vector2(40, 0),
    Vector2(0, 20)
  ],
  TetrominoType.lLeft: [
    Vector2(0, 0),
    Vector2(20, 0),
    Vector2(20, 20),
    Vector2(20, 40)
  ],
  TetrominoType.lDown: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(-20, 20),
    Vector2(-40, 20)
  ],
  TetrominoType.lRight: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(0, 40),
    Vector2(20, 40)
  ],
  TetrominoType.tUp: [
    Vector2(0, 0),
    Vector2(-20, 20),
    Vector2(0, 20),
    Vector2(20, 20)
  ],
  TetrominoType.tRight: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(0, 40),
    Vector2(20, 20)
  ],
  TetrominoType.tDown: [
    Vector2(0, 0),
    Vector2(20, 0),
    Vector2(40, 0),
    Vector2(20, 20)
  ],
  TetrominoType.tLeft: [
    Vector2(0, 0),
    Vector2(0, 20),
    Vector2(0, 40),
    Vector2(-20, 20)
  ],
};
