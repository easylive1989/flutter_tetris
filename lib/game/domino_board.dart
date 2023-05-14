import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoBoard extends Component with HasGameRef<TetrisGame> {

  @override
  Future onLoad() async {
    super.onLoad();
    add(Domino());
  }

  int get dominoCount => children.length;

  bool get isDominoReachTop => children.whereType<Domino>().any((domino) => domino.floor == 0 && domino.isStop);

  @override
  void update(double dt) {
    super.update(dt);
    var lastDomino = children.last as Domino;

    if (lastDomino.floor == 19 || isReachOtherDomino(lastDomino)) {
      lastDomino.stop();
      var sameRowDomino = children.whereType<Domino>().where((domino) => domino.floor == lastDomino.floor && domino.isStop);
      if (sameRowDomino.length == 10) {
        removeAll(sameRowDomino);
      }
      add(Domino());
    }
  }

  bool isReachOtherDomino(Domino lastDomino) => children.whereType<Domino>().any((domino) => domino.floor == lastDomino.floor + 1 && domino.column == lastDomino.column );

}
