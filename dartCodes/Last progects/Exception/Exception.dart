import 'dart:io';
import 'dart:convert';
void main(){
  var path = enterThePath();
  exception(path);
}

//Copy this path's:
//correct.json
//json_with_syntax_error.json

enterThePath(){
  // this is where the JSON file is read and serialized
  print("Enter the path, please");
  var path = stdin.readLineSync()!;


  while (path == '') {
    print("Enter the path, please");
    path = stdin.readLineSync()!;
  }
  return path;
}
exception (String path) async{
  var contents;
  try {       //exception operation
  contents = await File(path).readAsString();
    final Map<String, dynamic> data = jsonDecode(contents);
    var car = Car.fromJson(data);

  print(car.brand);
  print(car.model);
  print(car.color);
  print(car.carNumber);
  print(car.carOwnerName);
  }
  on FileSystemException{
    print("the program cannot find the specified path");
    main();
  }
  on FormatException{
    print("the file format is incorrect!");
    main();
  }
}

class Car {
  final String brand;
  final String model;
  final String color;
  final String carNumber;
  final String carOwnerName;

  Car({required this.brand, required this.color, required this.model,
    required this.carNumber, required this.carOwnerName});

  factory Car.fromJson(Map<String, dynamic> car) {
    return Car(brand: car["brand"], color: car["color"],  model: car["model"],
        carNumber: car["carNumber"], carOwnerName: car["carOwnerName"]);
  }
}