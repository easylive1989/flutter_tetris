import 'package:flame/components.dart';

class DominoBoardBorder extends Component {
  @override
  Future onLoad() async {
    super.onLoad();
    add(RectangleComponent(
      position: Vector2(0, 0),
      size: Vector2(1, 400),
    ));
    add(RectangleComponent(
      position: Vector2(199, 0),
      size: Vector2(1, 400),
    ));
    add(RectangleComponent(
      position: Vector2(0, 0),
      size: Vector2(200, 1),
    ));
    add(RectangleComponent(
      position: Vector2(0, 399),
      size: Vector2(200, 1),
    ));
  }
}