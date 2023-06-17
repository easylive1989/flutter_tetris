import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoBoard extends Component with HasGameRef<TetrisGame> {
  static const int _column = 10;
  static const int _row = 20;

  @override
  Future onLoad() async {
    super.onLoad();
  }

  int _eliminateCount = 0;

  int get _lastRow => _row - 1;

  int get dominoCount => children.length + _eliminateCount * _column;

  bool get isDominoReachTop => children
      .whereType<Domino>()
      .any((domino) => domino.floor == 0 && domino.isStop);

  @override
  void update(double dt) {
    super.update(dt);
    var lastDomino =
        children.whereType<Domino>().where((domino) => !domino.isStop);

    for (var domino in lastDomino) {
      if (domino.floor == _lastRow || _isReachOtherDomino(domino)) {
        for (var domino in lastDomino) {
          domino.stop();
          var dominoes = _sameRowDominoes(domino);
          if (dominoes.length == _column) {
            _eliminate(dominoes);
          }
        }
        addDomino();
        break;
      }
    }
  }

  void addDomino() {
    add(Domino(position: Vector2(0, 0)));
    add(Domino(position: Vector2(0, 20)));
    add(Domino(position: Vector2(20, 0)));
    add(Domino(position: Vector2(20, 20)));
  }

  void _eliminate(Iterable<Domino> dominoes) {
    removeAll(dominoes);
    _eliminateCount++;
  }

  Iterable<Domino> _sameRowDominoes(Domino lastDomino) => children
      .whereType<Domino>()
      .where((domino) => domino.floor == lastDomino.floor && domino.isStop);

  bool _isReachOtherDomino(Domino lastDomino) =>
      children.whereType<Domino>().any((domino) =>
          domino.isStop &&
          domino.celling == lastDomino.floor + 1 &&
          domino.column == lastDomino.column);
}
