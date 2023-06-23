import 'package:flutter_tetris/game/component/domino/domino.dart';

class StoppedDominoes {
  final Iterable<Domino> dominoes;

  StoppedDominoes(this.dominoes);

  Iterable<Domino> getByFloor(int floor) =>
      dominoes.where((domino) => domino.floor == floor);

  Iterable<Domino> getByTopOfFloor(int floor) =>
      dominoes.where((domino) => domino.floor < floor);
}
