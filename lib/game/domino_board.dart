import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoBoard extends Component with HasGameRef<TetrisGame> {
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

  bool get isDominoReachTop => _dominoSlots[0].any((slot) => slot);

  @override
  void update(double dt) {
    super.update(dt);
    var lastDomino = children.last as Domino;

    if (lastDomino.floor == 19 || isReachOtherDomino(lastDomino)) {
      _dominoSlots[lastDomino.floor][lastDomino.column] = true;
      add(Domino());
      lastDomino.stop();
    }
  }

  bool isReachOtherDomino(Domino lastDomino) => children.whereType<Domino>().any((domino) => domino.floor == lastDomino.floor + 1 && domino.column == lastDomino.column );

}
