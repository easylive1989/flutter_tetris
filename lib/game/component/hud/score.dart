import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetris/game/tetris_game.dart';

class Score extends HudMarginComponent<TetrisGame> {
  Score({super.margin});

  late TextComponent _text;

  @override
  Future onLoad() async {
    super.onLoad();

    add(_text = TextComponent(
      text: "Score: ${gameRef.score}",
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _text.text = "Score: ${gameRef.score}";
  }
}
