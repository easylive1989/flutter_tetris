import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/game/domino.dart';
import 'package:flutter_tetris/game/domino_generator.dart';
import 'package:flutter_tetris/game/stopped_dominoes.dart';
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
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        movingTetromino.isRightOfBoundary &&
        !movingTetromino.isRightOf(stoppedDominoes.dominoes)) {
      movingTetromino.moveRight();
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
        movingTetromino.isLeftOfBoundary &&
        !movingTetromino.isLeftOf(stoppedDominoes.dominoes)) {
      movingTetromino.moveLeft();
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      movingTetromino.rotate();
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      if (movingTetromino.isLastFloor) {
        return super.onKeyEvent(event, keysPressed);
      }
      if (movingTetromino.isTopOf(stoppedDominoes.dominoes)) {
        return super.onKeyEvent(event, keysPressed);
      }
      movingTetromino.moveToNextFloor();
    }

    return super.onKeyEvent(event, keysPressed);
  }

  int _eliminateCount = 0;

  int get dominoCount => children.length + _eliminateCount * _column;

  bool get isDominoReachTop => _getStoppedDominoes().getByFloor(0).isNotEmpty;

  @override
  void update(double dt) {
    super.update(dt);
    var tetromino = _getMovingTetromino();
    var stoppedDominoes = _getStoppedDominoes();

    if (!tetromino.isLastFloor &&
        !tetromino.isTopOf(stoppedDominoes.dominoes)) {
      return;
    }

    tetromino.stop();
    for (var domino in tetromino.dominoes) {
      var newStoppedDominoes = _getStoppedDominoes().getByFloor(domino.floor);
      if (newStoppedDominoes.length == _column) {
        _eliminate(newStoppedDominoes);
        _adjustDominoPosition(domino.floor);
      }
    }
    _dominoGenerator.generate(this);
  }

  void _adjustDominoPosition(int eliminateRow) {
    var dominoesAboveEliminateRow =
        _getStoppedDominoes().getByTopOfFloor(eliminateRow);
    for (var domino in dominoesAboveEliminateRow) {
      domino.moveToNextFloor();
    }
  }

  void _eliminate(Iterable<Domino> dominoes) {
    removeAll(dominoes);
    _eliminateCount++;
  }

  Tetromino _getMovingTetromino() => Tetromino(
      children.whereType<Domino>().where((domino) => !domino.isStop).toList());

  StoppedDominoes _getStoppedDominoes() => StoppedDominoes(
      children.whereType<Domino>().where((domino) => domino.isStop).toList());
}
