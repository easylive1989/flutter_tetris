
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tetris/game/domino.dart';

class TetrisGame extends FlameGame {
  Domino? _domino;

  @visibleForTesting
  Domino? get domino => _domino;

  @override
  Future onLoad() async {
    super.onLoad();

    _domino = Domino();
    add(_domino!);
  }
}
