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
    if (gameRef.dominoSlots[floor + 1][0]) {
      gameRef.dominoSlots[floor][0] = true;
      if (gameRef.dominoSlots[0][0]) {
        gameRef.isGameOver = true;
        gameRef.overlays.add('gameOver');
        gameRef.pauseEngine();
        return;
      }
      gameRef.add(Domino());
      gameRef.score += 1;
      _isStop = true;
    }
  }
}
