import 'Player.dart';
import 'Input.dart';

class Human extends Player{
  Input input = Input();
  String id = 'human';
  playerMove () {
    return input.InputMove;
  }
}
