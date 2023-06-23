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

    if (OTetrominoType.all.contains(offsets)) {
      return OTetrominoType(offsets);
    } else if (ITetrominoType.all.contains(offsets)) {
      return ITetrominoType(offsets);
    } else if (JTetrominoType.all.contains(offsets)) {
      return JTetrominoType(offsets);
    } else if (LTetrominoType.all.contains(offsets)) {
      return LTetrominoType(offsets);
    } else if (STetrominoType.all.contains(offsets)) {
      return STetrominoType(offsets);
    } else if (ZTetrominoType.all.contains(offsets)) {
      return ZTetrominoType(offsets);
    } else if (TTetrominoType.all.contains(offsets)) {
      return TTetrominoType(offsets);
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

class STetrominoType implements TType {
  static final sHorizontal = Shape(
    [Vector2(0, 0), Vector2(-20, 0), Vector2(-20, 20), Vector2(-40, 20)],
  );
  static final sVertical = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(20, 20), Vector2(20, 40)],
  );

  @override
  final Shape current;

  STetrominoType(this.current);

  static List<Shape> get all => [sHorizontal, sVertical];

  @override
  Shape get next => all[(all.indexOf(current) + 1) % all.length];
}

class ZTetrominoType implements TType {
  static final zHorizontal =
      Shape([Vector2(0, 0), Vector2(20, 0), Vector2(20, 20), Vector2(40, 20)]);
  static final zVertical = Shape(
      [Vector2(0, 0), Vector2(0, 20), Vector2(-20, 20), Vector2(-20, 40)]);

  @override
  final Shape current;

  ZTetrominoType(this.current);

  static List<Shape> get all => [zHorizontal, zVertical];

  @override
  Shape get next => all[(all.indexOf(current) + 1) % all.length];
}

class LTetrominoType implements TType {
  static final lUp = Shape(
    [Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(0, 20)],
  );
  static final lLeft = Shape(
    [Vector2(0, 0), Vector2(20, 0), Vector2(20, 20), Vector2(20, 40)],
  );
  static final lDown = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(-20, 20), Vector2(-40, 20)],
  );
  static final lRight = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(20, 40)],
  );
  @override
  final Shape current;

  LTetrominoType(this.current);

  static List<Shape> get all => [lUp, lLeft, lDown, lRight];

  @override
  Shape get next => all[(all.indexOf(current) + 1) % all.length];
}

class JTetrominoType implements TType {
  static final jUp = Shape(
    [Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(40, 20)],
  );
  static final jRight = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(-20, 40)],
  );
  static final jDown = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(20, 20), Vector2(40, 20)],
  );
  static final jLeft = Shape(
    [Vector2(0, 0), Vector2(20, 0), Vector2(0, 20), Vector2(0, 40)],
  );

  @override
  final Shape current;

  JTetrominoType(this.current);

  static List<Shape> get all => [jUp, jRight, jDown, jLeft];

  @override
  Shape get next => all[(all.indexOf(current) + 1) % all.length];
}

class TTetrominoType implements TType {
  static final tUp = Shape(
    [Vector2(0, 0), Vector2(-20, 20), Vector2(0, 20), Vector2(20, 20)],
  );
  static final tRight = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(20, 20)],
  );
  static final tDown = Shape(
    [Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(20, 20)],
  );
  static final tLeft = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(-20, 20)],
  );

  @override
  final Shape current;

  TTetrominoType(this.current);

  static List<Shape> get all => [tUp, tRight, tDown, tLeft];

  @override
  Shape get next => all[(all.indexOf(current) + 1) % all.length];
}