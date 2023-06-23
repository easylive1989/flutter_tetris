import 'package:flame/components.dart';
import 'package:flutter_tetris/game/tetromino/tetromino_type.dart';
import 'package:flutter_tetris/game/tetromino/tetromino_type_group.dart';

//  i4x1      i1x4
//    []    [][][][]
//    []
//    []
//    []
class ITypeGroup extends TetrominoTypeGroup {
  static final i4x1 =
      TetrominoType([Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(0, 60)]);
  static final i1x4 =
      TetrominoType([Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(60, 0)]);

  ITypeGroup(super.current);

  static List<TetrominoType> get all => [i4x1, i1x4];

  @override
  List<TetrominoType> get allOffsets => all;
}

//  o
// [][]
// [][]
class OTypeGroup extends TetrominoTypeGroup {
  static final o =
      TetrominoType([Vector2(0, 0), Vector2(0, 20), Vector2(20, 0), Vector2(20, 20)]);

  OTypeGroup(super.current);

  static List<TetrominoType> get all => [o];

  @override
  List<TetrominoType> get allOffsets => all;
}

//   sHorizontal    sVertical
//      [][]          []
//    [][]            [][]
//                      []
class STypeGroup extends TetrominoTypeGroup {
  static final sHorizontal = TetrominoType(
    [Vector2(0, 0), Vector2(-20, 0), Vector2(-20, 20), Vector2(-40, 20)],
  );
  static final sVertical = TetrominoType(
    [Vector2(0, 0), Vector2(0, 20), Vector2(20, 20), Vector2(20, 40)],
  );

  STypeGroup(super.current);

  static List<TetrominoType> get all => [sHorizontal, sVertical];

  @override
  List<TetrominoType> get allOffsets => all;
}

//  zHorizontal    zVertical
//    [][]            []
//      [][]        [][]
//                  []
class ZTypeGroup extends TetrominoTypeGroup {
  static final zHorizontal =
      TetrominoType([Vector2(0, 0), Vector2(20, 0), Vector2(20, 20), Vector2(40, 20)]);
  static final zVertical = TetrominoType(
      [Vector2(0, 0), Vector2(0, 20), Vector2(-20, 20), Vector2(-20, 40)]);

  ZTypeGroup(super.current);

  static List<TetrominoType> get all => [zHorizontal, zVertical];

  @override
  List<TetrominoType> get allOffsets => all;
}

//   lUp    lLeft   lDown   lRight
//  [][][]  [][]        []    []
//  []        []    [][][]    []
//            []              [][]
class LTypeGroup extends TetrominoTypeGroup {
  static final lUp = TetrominoType(
    [Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(0, 20)],
  );
  static final lLeft = TetrominoType(
    [Vector2(0, 0), Vector2(20, 0), Vector2(20, 20), Vector2(20, 40)],
  );
  static final lDown = TetrominoType(
    [Vector2(0, 0), Vector2(0, 20), Vector2(-20, 20), Vector2(-40, 20)],
  );
  static final lRight = TetrominoType(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(20, 40)],
  );

  LTypeGroup(super.current);

  static List<TetrominoType> get all => [lUp, lLeft, lDown, lRight];

  @override
  List<TetrominoType> get allOffsets => all;
}

//    jUp    jRight  jDown   jLeft
//   [][][]    []    []       [][]
//       []    []    [][][]   []
//           [][]             []
class JTypeGroup extends TetrominoTypeGroup {
  static final jUp = TetrominoType(
    [Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(40, 20)],
  );
  static final jRight = TetrominoType(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(-20, 40)],
  );
  static final jDown = TetrominoType(
    [Vector2(0, 0), Vector2(0, 20), Vector2(20, 20), Vector2(40, 20)],
  );
  static final jLeft = TetrominoType(
    [Vector2(0, 0), Vector2(20, 0), Vector2(0, 20), Vector2(0, 40)],
  );

  JTypeGroup(super.current);

  static List<TetrominoType> get all => [jUp, jRight, jDown, jLeft];

  @override
  List<TetrominoType> get allOffsets => all;
}

//    tUp      tRight    tDown    tLeft
//     []        []      [][][]      []
//   [][][]      [][]      []      [][]
//               []                  []
class TTypeGroup extends TetrominoTypeGroup {
  static final tUp = TetrominoType(
    [Vector2(0, 0), Vector2(-20, 20), Vector2(0, 20), Vector2(20, 20)],
  );
  static final tRight = TetrominoType(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(20, 20)],
  );
  static final tDown = TetrominoType(
    [Vector2(0, 0), Vector2(20, 0), Vector2(40, 0), Vector2(20, 20)],
  );
  static final tLeft = TetrominoType(
    [Vector2(0, 0), Vector2(0, 20), Vector2(0, 40), Vector2(-20, 20)],
  );

  TTypeGroup(super.current);

  static List<TetrominoType> get all => [tUp, tRight, tDown, tLeft];

  @override
  List<TetrominoType> get allOffsets => all;
}
