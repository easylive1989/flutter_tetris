import 'package:flame/components.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class Domino extends RectangleComponent with HasGameRef<TetrisGame> {
  static const double _dominoSize = 20.0;

  double _totalDelta = 0;
  bool _isStop = false;

  Domino({super.position}) : super(size: Vector2(_dominoSize, _dominoSize));

  int get floor => (position.y / _dominoSize).floor();

  int get column => (position.x / _dominoSize).floor();

  bool get isStop => _isStop;

  @override
  void update(double dt) {
    super.update(dt);
    if (_isStop) return;

    _totalDelta += dt;
    if (_totalDelta >= 1) {
      position.y += _dominoSize * _totalDelta.floor();
      _totalDelta -= _totalDelta.floor();
    }
  }

  void stop() {
    _isStop = true;
  }
}
