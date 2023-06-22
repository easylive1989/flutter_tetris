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

  bool isRightOf(Iterable<Domino> dominoes) =>
      dominoes.any((domino) => _isRightOf(domino));

  bool _isRightOf(Domino domino) =>
      domino.position.x == position.x + _dominoSize && floor == domino.floor;

  bool isLeftOf(Iterable<Domino> dominoes) =>
      dominoes.any((domino) => _isLeftOf(domino));

  bool _isLeftOf(Domino domino) {
    return domino.position.x == position.x - _dominoSize && floor == domino.floor;
  }

  bool isTopOf(Iterable<Domino> dominoes) =>
      dominoes.any((domino) => _isTopOf(domino));

  bool _isTopOf(domino) {
    return domino.position.x == position.x && floor == domino.floor - 1;
  }

  bool get isRightOfBoundary => position.x < 180;

  bool get isLeftOfBoundary => position.x > 0;

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

  void moveLeft() {
    position.x -= _dominoSize;
  }

  void moveRight() {
    position.x += _dominoSize;
  }

  void moveToNextFloor() {
    position.y += _dominoSize;
  }


}
