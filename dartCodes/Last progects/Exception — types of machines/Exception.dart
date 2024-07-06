import 'dart:io';
import 'dart:convert';
void main(){
  var path = enterThePath();
  exception(path);
}

//Copy this path's ==>  correct_bus.json
//                      correct_passenger.json
//                      correct_truck.json
//                      json_with_syntax_error.json
//                      non_correct_type.json

enterThePath(){
  // this is where the JSON file is read and serialized
  print("Enter the path, please");
  var path = stdin.readLineSync()!;

  while (path == "") {
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

  switch (car.type)  {      // (car.type != "passenger") || b != "truck" || b != ("bus")
    case "passenger":
    case "truck":
    case "bus":
      print(car.type);
      break;
    default:
      throw TypeMachineException();
  }
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
  on TypeMachineException {
    print("invalid machine type specified in the file");
    main();
  }
}

class TypeMachineException implements Exception{
}

class Car {
  final String type;
  final String brand;
  final String model;
  final String color;
  final String carNumber;
  final String carOwnerName;

  Car({required this.brand, required this.type, required this.color, required this.model,
    required this.carNumber, required this.carOwnerName});

  factory Car.fromJson(Map<String, dynamic> car) {
    return Car(type: car["type"], brand: car["brand"], color: car["color"],  model: car["model"],
        carNumber: car["carNumber"], carOwnerName: car["carOwnerName"]);
  }
}