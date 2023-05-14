import 'package:flame/components.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoManager extends Component with HasGameRef<TetrisGame> {
  List<List<bool>> dominoSlots = List.generate(21, (i) {
    return List.generate(10, (j) {
      return i == 20;
    }, growable: false);
  }, growable: false);
}
