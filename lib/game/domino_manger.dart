import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoManager extends Component with HasGameRef<TetrisGame> {
  final List<List<bool>> _dominoSlots = List.generate(21, (i) {
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

  bool get isDominoReachTop => _dominoSlots[0][0];

  @override
  void update(double dt) {
    super.update(dt);
    var lastDomino = children.last as Domino;
    if (_dominoSlots[lastDomino.floor + 1][0]) {
      _dominoSlots[lastDomino.floor][0] = true;
      add(Domino());
      lastDomino.stop();
    }
  }

}
