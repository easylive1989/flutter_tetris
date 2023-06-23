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
class Shape {
  final List<Vector2> offsets;

  Shape(this.offsets);

  @override
  bool operator ==(Object other) =>
      other is Shape &&
      const UnorderedIterableEquality().equals(offsets, other.offsets);

  @override
  int get hashCode => const UnorderedIterableEquality().hash(offsets);
}

abstract class TType {
  Shape get current;

  Shape get next;

  static TType from(List<Domino> dominoes) {
    var offsets = Shape(dominoes.map((domino) {
      return domino.position - dominoes[0].position;
    }).toList());

    if (ITetrominoType.all.contains(offsets)) {
      return ITetrominoType(offsets);
    }

    throw ArgumentError();
  }

  static void rotate(List<Domino> dominoes) {
    var nextShape = TType.from(dominoes).next;

    for (int index = 0; index < 4; index++) {
      dominoes[index].position =
          dominoes[0].position + nextShape.offsets[index];
    }
  }
}

class NoneTetrominoType implements TType {
  @override
  Shape get current => Shape([]);

  @override
  Shape get next => Shape([]);
}

class ITetrominoType implements TType {
  static final i4x1 =
      Shape([Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(0, 60)]);
  static final i1x4 =
      Shape([Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(60, 0)]);

  static List<Shape> get all => [i4x1, i1x4];

  @override
  final Shape current;

  ITetrominoType(this.current);

  @override
  Shape get next => all[(all.indexOf(current) + 1) % all.length];
}

class OTetrominoType implements TType {
  static final o =
      Shape([Vector2(0, 0), Vector2(0, 20), Vector2(20, 0), Vector2(20, 20)]);

  @override
  final Shape current;

  OTetrominoType(this.current);

  static List<Shape> get all => [o];

  @override
  Shape get next => all[(all.indexOf(current) + 1) % all.length];
}

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
