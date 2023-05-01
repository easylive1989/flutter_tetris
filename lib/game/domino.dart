import 'package:flame/components.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class Domino extends RectangleComponent with HasGameRef<TetrisGame> {
  double _totalDelta = 0;

  Domino() : super(size: Vector2(20, 20));

  @override
  void update(double dt) {
    super.update(dt);
    _totalDelta += dt;
    var floor = _totalDelta.floor();
    if (floor == 0) {
      gameRef.dominoSlots[floor][0] = true;
      position.y = 20.0 * floor;
    } else if (floor < 20) {
      gameRef.dominoSlots[floor - 1][0] = false;
      gameRef.dominoSlots[floor][0] = true;
      position.y = 20.0 * floor;
      game.add(Domino());
    }
  }
}
