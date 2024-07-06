import 'Player.dart';
import 'dart:math';

class Bot extends Player{
  String id = 'bot';
  playerMove(){
    Random random = Random();
    row = random.nextInt(3);
    col = random.nextInt(3);
    List <int> move = [row, col];
    return move;
  }
}
