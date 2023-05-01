import 'package:flame/components.dart';

class Domino extends RectangleComponent with HasGameRef {
  Domino() : super(size: Vector2(30, 30));

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 30 * dt;
    if (position.y + size.y > game.size.y) {
      position.y = game.size.y - size.y;
    }
  }
}
