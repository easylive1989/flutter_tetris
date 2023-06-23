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

abstract class TetrominoType {
  final Shape current;

  TetrominoType(this.current);

  Shape get next =>
      allOffsets[(allOffsets.indexOf(current) + 1) % allOffsets.length];

  List<Shape> get allOffsets;

  static TetrominoType from(List<Domino> dominoes) {
    var offsets = Shape(dominoes.map((domino) {
      return domino.position - dominoes[0].position;
    }).toList());

    if (TetrominoOType.all.contains(offsets)) {
      return TetrominoOType(offsets);
    } else if (TetrominoIType.all.contains(offsets)) {
      return TetrominoIType(offsets);
    } else if (TetrominoJType.all.contains(offsets)) {
      return TetrominoJType(offsets);
    } else if (TetrominoLType.all.contains(offsets)) {
      return TetrominoLType(offsets);
    } else if (TetrominoSType.all.contains(offsets)) {
      return TetrominoSType(offsets);
    } else if (TetrominoZType.all.contains(offsets)) {
      return TetrominoZType(offsets);
    } else if (TetrominoTType.all.contains(offsets)) {
      return TetrominoTType(offsets);
    }

    throw ArgumentError();
  }

  static void rotate(List<Domino> dominoes) {
    var nextShape = TetrominoType.from(dominoes).next;

    for (int index = 0; index < 4; index++) {
      dominoes[index].position =
          dominoes[0].position + nextShape.offsets[index];
    }
  }
}

class TetrominoIType extends TetrominoType {
  static final i4x1 =
      Shape([Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(0, 60)]);
  static final i1x4 =
      Shape([Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(60, 0)]);

  TetrominoIType(super.current);

  static List<Shape> get all => [i4x1, i1x4];

  @override
  List<Shape> get allOffsets => all;
}

class TetrominoOType extends TetrominoType {
  static final o =
      Shape([Vector2(0, 0), Vector2(0, 20), Vector2(20, 0), Vector2(20, 20)]);

  TetrominoOType(super.current);

  static List<Shape> get all => [o];

  @override
  List<Shape> get allOffsets => all;
}

class TetrominoSType extends TetrominoType {
  static final sHorizontal = Shape(
    [Vector2(0, 0), Vector2(-20, 0), Vector2(-20, 20), Vector2(-40, 20)],
  );
  static final sVertical = Shape(
    [Vector2(0, 0), Vector2(0, 20), Vector2(20, 20), Vector2(20, 40)],
  );

  TetrominoSType(super.current);

  static List<Shape> get all => [sHorizontal, sVertical];

  @override
  List<Shape> get allOffsets => all;
}

class TetrominoZType extends TetrominoType {
  static final zHorizontal =
      Shape([Vector2(0, 0), Vector2(20, 0), Vector2(20, 20), Vector2(40, 20)]);
  static final zVertical = Shape(
      [Vector2(0, 0), Vector2(0, 20), Vector2(-20, 20), Vector2(-20, 40)]);

  TetrominoZType(super.current);

  static List<Shape> get all => [zHorizontal, zVertical];

  @override
  List<Shape> get allOffsets => all;
}

class TetrominoLType extends TetrominoType {
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

  TetrominoLType(super.current);

  static List<Shape> get all => [lUp, lLeft, lDown, lRight];

  @override
  List<Shape> get allOffsets => all;
}

class TetrominoJType extends TetrominoType {
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

  TetrominoJType(super.current);

  static List<Shape> get all => [jUp, jRight, jDown, jLeft];

  @override
  List<Shape> get allOffsets => all;
}

class TetrominoTType extends TetrominoType {
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

  TetrominoTType(super.current);

  static List<Shape> get all => [tUp, tRight, tDown, tLeft];

  @override
  List<Shape> get allOffsets => all;
}
