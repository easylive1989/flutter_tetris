import 'package:flame/components.dart';

class Domino extends RectangleComponent {
  Domino() : super(size: Vector2(30, 30));

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 30 * dt;
  }
}