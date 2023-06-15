import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetris/game/domino_board.dart';
import 'package:flutter_tetris/game/domino_board_border.dart';
import 'package:flutter_tetris/game/score.dart';

class TetrisGame extends FlameGame with HasKeyboardHandlerComponents {
  DominoBoard? _dominoBoard;

  @visibleForTesting
  DominoBoard get dominoBoard => _dominoBoard!;

  int get score => _dominoBoard?.dominoCount ?? 0;

  @override
  Future onLoad() async {
    super.onLoad();

    add(DominoBoardBorder());
    add(_dominoBoard = DominoBoard());
    add(Score(margin: const EdgeInsets.only(top: 5, left: 210)));
  }

  Future restart() async {
    overlays.remove(overlays.activeOverlays.first);
    removeAll(children.whereType<DominoBoard>());
    add(_dominoBoard = DominoBoard());
    resumeEngine();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_dominoBoard?.isDominoReachTop ?? false) {
      overlays.add('gameOver');
      pauseEngine();
    }
  }
}
