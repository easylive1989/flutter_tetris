import 'package:collection/collection.dart';
import 'package:flame/components.dart';

class TetrominoType {
  final List<Vector2> offsets;

  TetrominoType(this.offsets);

  @override
  bool operator ==(Object other) =>
      other is TetrominoType &&
          const UnorderedIterableEquality().equals(offsets, other.offsets);

  @override
  int get hashCode => const UnorderedIterableEquality().hash(offsets);
}

