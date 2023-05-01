import 'package:flame/components.dart';

class Domino extends RectangleComponent with HasGameRef {
  bool _isStop = false;

  Domino() : super(size: Vector2(30, 30));

  @override
  void update(double dt) {
    super.update(dt);
    if (position.y + size.y + 30 * dt <= game.size.y) {
      position.y += 30 * dt;
      return;
    }
    if (!_isStop) {
      game.add(Domino());
      _isStop = true;
    }
  }
}
