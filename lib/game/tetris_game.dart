import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetris/game/component/domino/domino_board.dart';
import 'package:flutter_tetris/game/component/hud/domino_board_border.dart';
import 'package:flutter_tetris/game/component/domino/domino_generator.dart';
import 'package:flutter_tetris/game/component/hud/score.dart';

class TetrisGame extends FlameGame with HasKeyboardHandlerComponents {
  DominoGenerator? _dominoGenerator;
  DominoBoard? _dominoBoard;

  @visibleForTesting
  DominoBoard get dominoBoard => _dominoBoard!;

  int get score => _dominoBoard?.dominoCount ?? 0;

  TetrisGame({DominoGenerator? dominoGenerator}) {
    _dominoGenerator = dominoGenerator ?? RandomTetrominoGenerator();
  }

  @override
  Future onLoad() async {
    super.onLoad();

    var startPosition = size / 2 - Vector2(100, 200);
    add(DominoBoardBorder(position: startPosition));
    add(_dominoBoard = DominoBoard(_dominoGenerator!, position: startPosition));
    // add(Score(margin: const EdgeInsets.only(top: 5, left: 210)));
    add(Score(
      margin: EdgeInsets.only(
        top: startPosition.y + 5,
        left: startPosition.x + 210,
      ),
    ));
  }

  Future restart() async {
    overlays.remove(overlays.activeOverlays.first);
    removeAll(children.whereType<DominoBoard>());
    add(_dominoBoard = DominoBoard(_dominoGenerator!));
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
