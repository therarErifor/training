class Field {

 final size;

 Field({required this.size});

  FieldGenerate (){
    List <List<int>> _grid = List<List<int>>.generate(size,
            (i) => List<int>.generate(size, (j) => 0));
  return _grid;
  }

  set setGrid (GameGrid){
    List _grid = GameGrid;
  }
}






