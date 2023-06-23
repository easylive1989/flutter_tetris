import 'package:flutter_tetris/game/component/domino/domino.dart';
import 'package:flutter_tetris/game/tetromino_type/tetromino_type.dart';
import 'package:flutter_tetris/game/tetromino_type/tetromino_typ_group_impl.dart';

abstract class TetrominoTypeGroup {
  final TetrominoType current;

  TetrominoTypeGroup(this.current);

  TetrominoType get next =>
      allOffsets[(allOffsets.indexOf(current) + 1) % allOffsets.length];

  List<TetrominoType> get allOffsets;

  static TetrominoTypeGroup from(List<Domino> dominoes) {
    var offsets = TetrominoType(dominoes.map((domino) {
      return domino.position - dominoes[0].position;
    }).toList());

    if (OTypeGroup.all.contains(offsets)) {
      return OTypeGroup(offsets);
    } else if (ITypeGroup.all.contains(offsets)) {
      return ITypeGroup(offsets);
    } else if (JTypeGroup.all.contains(offsets)) {
      return JTypeGroup(offsets);
    } else if (LTypeGroup.all.contains(offsets)) {
      return LTypeGroup(offsets);
    } else if (STypeGroup.all.contains(offsets)) {
      return STypeGroup(offsets);
    } else if (ZTypeGroup.all.contains(offsets)) {
      return ZTypeGroup(offsets);
    } else if (TTypeGroup.all.contains(offsets)) {
      return TTypeGroup(offsets);
    }

    throw ArgumentError();
  }

  static void rotate(List<Domino> dominoes) {
    var nextShape = TetrominoTypeGroup.from(dominoes).next;

    for (int index = 0; index < 4; index++) {
      dominoes[index].position =
          dominoes[0].position + nextShape.offsets[index];
    }
  }
}