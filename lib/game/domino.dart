import 'package:flame/components.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class Domino extends RectangleComponent with HasGameRef<TetrisGame> {
  double _totalDelta = 0;
  bool _isStop = false;

  Domino() : super(size: Vector2(20, 20));

  @override
  void update(double dt) {
    super.update(dt);
    _totalDelta += dt;
    if (_isStop) return;
    var floor = _totalDelta.floor();
    position.y = 20.0 * floor;
    if (floor >= 19) {
      gameRef.dominoSlots[19][0] = true;
      position.y = 20.0 * 19;
      game.add(Domino());
      _isStop = true;
    } else if (gameRef.dominoSlots[floor + 1][0]) {
      gameRef.dominoSlots[floor][0] = true;
      position.y = 20.0 * floor;
      game.add(Domino());
      _isStop = true;
    }
  }
}
