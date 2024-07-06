import 'dart:io';

class Input {
  var row;
  var col;

  List get InputMove {
    try {
      print('введите строку:');
      row = int.parse(stdin.readLineSync()!);
      print('введите столбец:');
      col = int.parse(stdin.readLineSync()!);
      --row;
      --col;
      while ((row > 2) || (col > 2)) {
        print('Пожалуйста, введите другие числа!');
        print('введите строку:');
        row = int.parse(stdin.readLineSync()!);
        print('введите столбец:');
        col = int.parse(stdin.readLineSync()!);
        --row;
        --col;
      }
    }
    on FormatException{
        print('Пожалуйста, введите числа!');
        print('введите строку:');
        row = int.parse(stdin.readLineSync()!);
        print('введите столбец:');
        col = int.parse(stdin.readLineSync()!);
        --row;
        --col;
    }
    List <int> move = [row, col];
    return move;
  }
}