import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/domino_generator.dart';
import 'package:flutter_tetris/game/tetris_game.dart';
import 'package:flutter_tetris/game/tetromino.dart';

class DominoBoard extends Component
    with HasGameRef<TetrisGame>, KeyboardHandler {
  static const int _column = 10;

  final DominoGenerator _dominoGenerator;

  DominoBoard(DominoGenerator dominoGenerator)
      : _dominoGenerator = dominoGenerator;

  @override
  Future onLoad() async {
    super.onLoad();
    _dominoGenerator.generate(this);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var movingTetromino = _getMovingTetromino();
    var stoppedDominoes = _getStoppedDominoes();
    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) &&
        movingTetromino.isRightOfBoundary &&
        !movingTetromino.isRightOf(stoppedDominoes)) {
      movingTetromino.moveRight();
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) &&
        movingTetromino.isLeftOfBoundary &&
        !movingTetromino.isLeftOf(stoppedDominoes)) {
      movingTetromino.moveLeft();
    }

    return super.onKeyEvent(event, keysPressed);
  }

  Iterable<Domino> _getStoppedDominoes() =>
      children.whereType<Domino>().where((domino) => domino.isStop).toList();

  int _eliminateCount = 0;

  int get dominoCount => children.length + _eliminateCount * _column;

  bool get isDominoReachTop => children
      .whereType<Domino>()
      .any((domino) => domino.floor == 0 && domino.isStop);

  @override
  void update(double dt) {
    super.update(dt);
    var movingTetromino = _getMovingTetromino();
    var stoppedDominoes = _getStoppedDominoes();

    if (movingTetromino.isLastFloor ||
        movingTetromino.isTopOf(stoppedDominoes)) {
      movingTetromino.stop();
      for (var domino in movingTetromino.dominoes) {
        var dominoes = _sameRowDominoes(domino);
        if (dominoes.length == _column) {
          _eliminate(dominoes);
          _adjustDominoPosition(domino.floor);
        }
      }
      _dominoGenerator.generate(this);
    }
  }

  void _adjustDominoPosition(int eliminateRow) {
    var dominoesAboveEliminateRow = children
        .whereType<Domino>()
        .where((domino) => domino.floor < eliminateRow);
    for (var domino in dominoesAboveEliminateRow) {
      domino.moveToNextFloor();
    }
  }

  Tetromino _getMovingTetromino() => Tetromino(
      children.whereType<Domino>().where((domino) => !domino.isStop).toList());

  void _eliminate(Iterable<Domino> dominoes) {
    removeAll(dominoes);
    _eliminateCount++;
  }

  Iterable<Domino> _sameRowDominoes(Domino lastDomino) => children
      .whereType<Domino>()
      .where((domino) => domino.floor == lastDomino.floor && domino.isStop);
}
