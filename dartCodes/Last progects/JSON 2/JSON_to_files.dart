import 'dart:io';
import 'dart:convert';


void main(){
  print("Введите данные об автомобиле");
  var brand = check(text:"Марка");
  var model = check(text: "Модель");
  var color = check(text:"Цвет");
  var carNumber = check(text: "Госномер" );
  var carOwnerName = check(text: "Имя владельца");

  Car tom = Car(brand: brand, model: model, color: color,
      carNumber: carNumber, carOwnerName: carOwnerName);
  jsonEncode(tom);
  writeReadFile (jsonEncode(tom));
}

writeReadFile (var json) async {
  var file = new File('Test.txt');
  var sink = file.openWrite();
  var contents;
  sink.write(json);
  sink.close();
  if (await file.exists()) {
    contents = await file.readAsString();
  }
  final Map<String, dynamic> data = jsonDecode(contents);
  var car = Car.fromJson(data);
  print(car.brand);
  print(car.model);
  print(car.color);
  print(car.carNumber);
  print(car.carOwnerName);
}
check({var text, data}) {
  print("$text автомобиля:");
  data = stdin.readLineSync()!;
  text = text.toLowerCase();
  while (data == "") {
    print("Пожалуйста, введите $text автомобиля!:");
    data = stdin.readLineSync()!;
  };
  return data;
}

class Car {
  final String brand;
  final String model;
  final String color;
  final String carNumber;
  final String carOwnerName;

  Car({required this.brand, required this.color, required this.model,
    required this.carNumber, required this.carOwnerName});

  Map<String, dynamic> toJson() {
    return {
      "brand": brand,
      "model": model,
      "color": color,
      "carNumber": carNumber,
      "carOwnerName": carOwnerName,
    };
  }
  factory Car.fromJson(Map<String, dynamic> car) {
    return Car(brand: car["brand"], color: car["color"],  model: car["model"],
        carNumber: car["carNumber"], carOwnerName: car["carOwnerName"]);
  }
}