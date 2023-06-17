import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class Domino extends RectangleComponent with HasGameRef<TetrisGame>, KeyboardHandler {
  static const double _dominoSize = 20.0;

  double _totalDelta = 0;
  bool _isStop = false;

  Domino({super.position}) : super(size: Vector2(_dominoSize, _dominoSize));

  int get floor => (position.y / _dominoSize).floor();

  int get celling => floor;

  int get column => (position.x / _dominoSize).floor();

  bool get isStop => _isStop;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (_isStop) return super.onKeyEvent(event, keysPressed);

    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) && position.x < _dominoSize * 9) {
      position.x += _dominoSize;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) && position.x > 0) {
      position.x -= _dominoSize;
    }

    return super.onKeyEvent(event, keysPressed);
  }

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
