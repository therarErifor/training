import "dart:io";
import 'dart:math';

void main() {
print("hello, world");
  game();

}

game(){
  PoleOutput go = PoleOutput(0,0,[""]);
  var checkList;
  var check;
  var checkDroid;
  do{
    go.PlayerMove();
    go.droidMove();
    go.output();
    checkList = Check(go.grid);
    check = checkList[0];
    checkDroid = checkList[1];
    if(check == true){
      print("Вы победили, в кои то веки!");
      break;
    }else
    if (checkDroid == true){
      print('Вы проиграли');
      break;
    }
  }
  while ((check != true) | (checkDroid != true));
  print('Подтвердите выход');
  var exit = stdin.readLineSync()!;

}

class Player extends Pole{ //ввод игроком X
  Player(int a, int b, List grid) : super(a:a, b:b, grid:b);
  PlayerMove() {
    print('введите строку:');
    a = int.parse(stdin.readLineSync()!);
    print('введите столбец:');
    b = int.parse(stdin.readLineSync()!);
    --a;
    --b;
    while ((a > 2)||(b > 2)||(grid [a] [b] == 'O') || (grid [a] [b] == 'X')){
      print('Пожалуйста, введите другие данные');
      print('введите строку:');
      a = int.parse(stdin.readLineSync()!);
      print('введите столбец:');
      b = int.parse(stdin.readLineSync()!);
      --a;
      --b;
    }
    grid [a] [b] = 'X';
    a = 0;
    b = 0;
  }
}

class Droid extends Player{
  Droid(int a, int b, List grid) : super(a, b, grid);
  droidMove(){
    Random random = Random();
    a = random.nextInt(3);
    b = random.nextInt(3);
    while ((grid [a] [b] == 'X')||(grid [a] [b] == 'O')){
      a = random.nextInt(3);
      b = random.nextInt(3);
    }
    grid [a] [b] = 'O';
  }
}


class PoleOutput extends Droid{ //вывод массива
  PoleOutput(int a, int b, List grid) : super(a, b, grid);
  output() {
    for (var n in grid) {
      stdout.write(n);
      print('');
    }
  }

}

class Pole{  //Создание двумерного массива
  var grid;
  int a;
  int b;
  Pole({required this.grid, required this.a, required this.b}){
    grid = List<List<String>>.generate(3,
            (i) => List<String>.generate(3, (j) => "_"));
  }
}

Check(List grid){
  var count = 0;
  var countDroid = 0;
  var rer = false;
  var rerDroid = false;

    for (int i = 0; i <= 2; i++) {
      for (int j = 0; j <= 2; j++) {
        if ((grid [i][j] == "X")&(j == i)) { //главная диагональ
          count++;
        }
        if ((grid [i][j] == "O")&(j == i)) { //главная диагональ
          countDroid++;
        }
      }
    }
  if (count == 3){
    rer = true;
  }else if (countDroid == 3){
    rerDroid = true;
  }
// следующая проверка
    count = 0;
    countDroid = 0;
    for (int i = 0; i<=2; i++){
      for (int j = 0; j<=2;j++){
        if ((grid [i][j] == "X")&(i+j == 2)){    //побочная диагональ
          count++;
        }
        if ((grid [i][j] == "O")&(i+j == 2)){    //побочная диагональ
          countDroid++;
        }
      }
    }
  if (count == 3){
    rer = true;
  }else if (countDroid == 3){
    rerDroid = true;
  }
// следующая проверка
    count = 0;
    countDroid = 0;
    for (int i = 0; i<=2; i++){
      if (grid [i][0] == "X"){
        count++;
      }
      if (grid [i][0] == "O"){
        countDroid++;
      }
    }
  if (count == 3){
    rer = true;
  }else if (countDroid == 3){
    rerDroid = true;
  }
// следующая проверка
      count = 0;
      countDroid = 0;
      for (int i = 0; i<=2; i++){
        if (grid [i][1] == "X"){
          count++;
        }
        if (grid [i][1] == "O"){
          countDroid++;
        }
      }
  if (count == 3){
    rer = true;
  }else if (countDroid == 3){
    rerDroid = true;
  }

// следующая проверка
    count = 0;
    countDroid = 0;
    for (int i = 0; i<=2; i++){
      if (grid [i][2] == "X"){
        count++;
      }
      if (grid [i][2] == "O"){
        countDroid++;
      }
    }
    if (count == 3){
      rer = true;
    }else if (countDroid == 3){
      rerDroid = true;
    }

// следующая проверка
    count = 0;
    countDroid = 0;
    for (int i = 0; i<=2; i++){
      if (grid [0][i] == "X"){
        count++;
      }
      if (grid [0][i] == "O"){
        countDroid++;
      }
    }
  if (count == 3){
    rer = true;
  }else if (countDroid == 3){
    rerDroid = true;
  }
// следующая проверка
    count = 0;
    countDroid = 0;
    for (int i = 0; i<=2; i++){
      if (grid [1][i] == "X"){
        count++;
      }
      if (grid [1][i] == "O"){
        countDroid++;
      }
    }
  if (count == 3){
    rer = true;
  }else if (countDroid == 3){
    rerDroid = true;
  }
// следующая проверка
    count = 0;
    countDroid = 0;
    for (int i = 0; i<=2; i++){
      if (grid [2][i] == "X"){
        count++;
      }
      if (grid [2][i] == "O"){
        countDroid++;
      }
    }
  if (count == 3){
    rer = true;
  }else if (countDroid == 3){
    rerDroid = true;
  }
  List <bool> countList = [rer, rerDroid];
  return countList;
}
