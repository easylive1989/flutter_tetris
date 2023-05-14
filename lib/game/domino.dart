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
    if (_isStop) return;

    _totalDelta += dt;
    position.y = _dominoSize * floor;
    if (gameRef.dominoManager.dominoSlots[floor + 1][0]) {
      gameRef.dominoManager.dominoSlots[floor][0] = true;
      if (gameRef.dominoManager.dominoSlots[0][0]) {
        gameRef.isGameOver = true;
        return;
      }
      gameRef.dominoManager.add(Domino());
      gameRef.score += 1;
      _isStop = true;
    }
  }

  int get floor => _totalDelta.floor();
}
