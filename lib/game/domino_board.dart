import 'package:flame/components.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/domino_generator.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class DominoBoard extends Component with HasGameRef<TetrisGame> {
  static const int _column = 10;
  static const int _row = 20;

  final DominoGenerator _dominoGenerator;

  DominoBoard(DominoGenerator dominoGenerator)
      : _dominoGenerator = dominoGenerator;

  @override
  Future onLoad() async {
    super.onLoad();
    _dominoGenerator.generate(this);
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
    var movingDominoes = _getMovingDominoes();

    for (var movingDomino in movingDominoes) {
      if (movingDomino.floor == _lastRow || _isReachStopDomino(movingDomino)) {
        for (var domino in movingDominoes) {
          domino.stop();
          var dominoes = _sameRowDominoes(domino);
          if (dominoes.length == _column) {
            _eliminate(dominoes);
            _adjustDominoPosition(domino.floor);
          }
        }
        _dominoGenerator.generate(this);
        break;
      }
    }
  }

  void _adjustDominoPosition( int eliminateRow) {
    var dominoesAboveEliminateRow = children.whereType<Domino>().where((domino) => domino.floor < eliminateRow);
    for (var domino in dominoesAboveEliminateRow) {
      domino.position.y += 20;
    }
  }

  Iterable<Domino> _getMovingDominoes() =>
      children.whereType<Domino>().where((domino) => !domino.isStop);

  void _eliminate(Iterable<Domino> dominoes) {
    removeAll(dominoes);
    _eliminateCount++;
  }

  Iterable<Domino> _sameRowDominoes(Domino lastDomino) => children
      .whereType<Domino>()
      .where((domino) => domino.floor == lastDomino.floor && domino.isStop);

  bool _isReachStopDomino(Domino lastDomino) =>
      children.whereType<Domino>().any((domino) =>
          domino.isStop &&
          domino.floor == lastDomino.floor + 1 &&
          domino.column == lastDomino.column);
}
