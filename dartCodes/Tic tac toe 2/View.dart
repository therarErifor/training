import 'dart:io';
class View{
  output(List <List<dynamic>> grid){
    for (int i=0; i <= 2; i++ ){
      for (int j=0; j <=2; j++){
        if (grid [i][j] == 0){
          stdout.write(' _ ');
        }else if (grid [i][j] == 1){
          stdout.write(' X ');
        }else if (grid [i][j] == 2){
          stdout.write(' O ');
        }
      }
      print('');
    }
  }
}