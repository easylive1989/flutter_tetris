import 'package:flame/components.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class Domino extends RectangleComponent with HasGameRef<TetrisGame> {
  static const double _dominoSize = 20.0;

  double _totalDelta = 0;
  bool _isStop = false;

  Domino() : super(size: Vector2(_dominoSize, _dominoSize));

  @override
  void update(double dt) {
    super.update(dt);
    _totalDelta += dt;
    if (_isStop) return;

    var floor = _totalDelta.floor();
    position.y = _dominoSize * floor;
    if (gameRef.dominoManager.dominoSlots[floor + 1][0]) {
      gameRef.dominoManager.dominoSlots[floor][0] = true;
      if (gameRef.dominoManager.dominoSlots[0][0]) {
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
