import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoBoard extends Component with HasGameRef<TetrisGame> {

  @override
  Future onLoad() async {
    super.onLoad();
    add(Domino());
  }

  int _eliminateCount = 0;

  int get dominoCount => children.length + _eliminateCount * 10;

  bool get isDominoReachTop => children.whereType<Domino>().any((domino) => domino.floor == 0 && domino.isStop);

  @override
  void update(double dt) {
    super.update(dt);
    var lastDomino = children.last as Domino;

    if (lastDomino.floor == 19 || _isReachOtherDomino(lastDomino)) {
      lastDomino.stop();
      var dominoes = _sameRowDominoes(lastDomino);
      if (dominoes.length == 10) {
        removeAll(dominoes);
        _eliminateCount++;
      }
      add(Domino());
    }
  }

  Iterable<Domino> _sameRowDominoes(Domino lastDomino) => children.whereType<Domino>().where((domino) => domino.floor == lastDomino.floor && domino.isStop);

  bool _isReachOtherDomino(Domino lastDomino) => children.whereType<Domino>().any((domino) => domino.floor == lastDomino.floor + 1 && domino.column == lastDomino.column );

}
