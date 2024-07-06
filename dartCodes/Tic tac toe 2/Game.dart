import 'dart:io';
import 'Field.dart';
import 'Player/Human.dart';
import 'Player/Bot.dart';
import 'Player/Player.dart';
import 'StateGame.dart';
import 'View.dart';

class Game{
  StateGame stateGame = StateGame();
  Field field = Field(size: 3);
  View view = View();
  var value = '_';
  Player player1 = Human();
  Player player2 = Human();

  Start() {
    print('Если хотите начать стандартную игру с ботом, введите "s"; \n'
      ' если хотите играть с другим человеком, введите "m"');
      value = stdin.readLineSync()!;

    if (value == 's') {
      player2 = Bot();
      GameCycle();
    }else if (value == 'm'){
      player2 = Human();
      GameCycle();
    }
  }

  GameCycle(){
    String whoWon = '';
    List grid = field.FieldGenerate();
    player1.symbol = 1;
    player2.symbol = 2;

    do {
      print('\n Ходит крестик');
      var move = player1.playerMove();
      while (grid[move[0]][move[1]] == 1
          || grid[move[0]][move[1]] == 2) {
        print('Пожалуйста, введите другие данные');
        move = player1.playerMove();
      }
      view.output(stateGame.state(grid, move, player1.symbol));
      field.setGrid = stateGame.state(grid, move, player1.symbol);
      whoWon = Check(grid);
      if (whoWon == 'full') {
        print('Ничья!');
      }else if (whoWon != 'nobody'){
        break;
      }else{
          print('\n Ходит Нолик');
          move = player2.playerMove();
          while (grid[move[0]][move[1]] == 1
              || grid[move[0]][move[1]] == 2) {
            if (player2.id == 'human') {
              print('Пожалуйста, введите другие данные');
            }
            move = player2.playerMove();
          }
          view.output(stateGame.state(grid, move, player2.symbol));
          field.setGrid = stateGame.state(grid, move, player2.symbol);
          whoWon = Check(grid);
          if (whoWon == 'ничья!'){
            print('Ничья!');
          }else if (whoWon != 'nobody') {
            break;
          }
        }
    }while(whoWon == 'nobody');
    print('Подтвердите выход');
    var exit = stdin.readLineSync()!;
  }
}

_CheckWhoWon(int countPlayer1, int countPlayer2){
  var whoWon;
    if (countPlayer1 == 3) {
      whoWon = 'FirstPlayer';
      print('Победил крестик!');
    } else if (countPlayer2 == 3) {
      whoWon = 'SecondPlayer';
      print('Победил нолик!');
    } else {
      whoWon = 'nobody';
    }
  return whoWon;
}

Check(grid) {
  int countPlayer1 = 0;
  int countPlayer2 = 0;
  String whoWon = 'nobody';
  int countField = 0;

  for (int i = 0; i==0; i++){
    countPlayer1 = 0;
    countPlayer2 = 0;
    for (int i = 0; i <= 2; i++) {
      for (int j = 0; j <= 2; j++) {
        if ((grid [i][j] == 1) & (j == i)){//главная диагональ
          countPlayer1++;
        }
        if ((grid [i][j] == 2) & (j == i)){ //главная диагональ
          countPlayer2++;
        }
      }
      whoWon = _CheckWhoWon(countPlayer1, countPlayer2);
      if (whoWon != 'nobody') {break;}
    }
    if (whoWon != 'nobody') {break;}

    countPlayer1 = 0;
    countPlayer2 = 0;
    for (int i = 0; i <= 2; i++) {
      for (int j = 0; j <= 2; j++) {
        if ((grid [i][j] == 1) & (i + j == 2)){//побочная диагональ
          countPlayer1++;
        }
        if ((grid [i][j] == 2) & (i + j == 2)){//побочная диагональ
          countPlayer2++;
        }
      }
      whoWon = _CheckWhoWon(countPlayer1, countPlayer2);
      if (whoWon != 'nobody') {break;}
    }
    if (whoWon != 'nobody') {break;}

// следующая проверка (все столбцы)
    for (int j=0; j<=2; j++) {
      countPlayer1 = 0;
      countPlayer2 = 0;
      for (int i = 0; i <= 2; i++) {
        if (grid [i][j] == 1) {
          countPlayer1++;
        }
        if (grid [i][j] == 2) {
          countPlayer2++;
        }
      }
      whoWon = _CheckWhoWon(countPlayer1, countPlayer2);
      if (whoWon != 'nobody') {break;}
    }
    if (whoWon != 'nobody') {break;}

// следующая проверка (все строки)
    for (int j=0; j<=2; j++) {
      countPlayer1 = 0;
      countPlayer2 = 0;
      for (int i = 0; i <= 2; i++) {
        if (grid [j][i] == 1) {
          countPlayer1++;
        }
        if (grid [j][i] == 2) {
          countPlayer2++;
        }
      }
      whoWon = _CheckWhoWon(countPlayer1, countPlayer2);
      if (whoWon != 'nobody') {break;}
    }
    if (whoWon != 'nobody') {break;}

    for (int i = 0; i <= 2; i++) {
      for (int j = 0; j <= 2; j++) {
        if (grid [i][j] == 0) {
          countField++;
        }
      }
    }

    if (countField == 0){
      whoWon = 'full';
      break;
    }
  }
  return whoWon;
}