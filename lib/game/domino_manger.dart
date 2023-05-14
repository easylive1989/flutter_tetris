import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoManager extends Component with HasGameRef<TetrisGame> {
  final List<List<bool>> dominoSlots = List.generate(21, (i) {
    return List.generate(10, (j) {
      return i == 20;
    }, growable: false);
  }, growable: false);

  @override
  Future onLoad() async {
    super.onLoad();
    add(Domino());
  }

  int get dominoCount => children.length;

  @override
  void update(double dt) {
    super.update(dt);
    var lastDomino = children.last as Domino;
    if (dominoSlots[lastDomino.floor + 1][0]) {
      dominoSlots[lastDomino.floor][0] = true;
      add(Domino());
      lastDomino.stop();
    }
  }

  bool get isDominoReachTop => dominoSlots[0][0];
}
