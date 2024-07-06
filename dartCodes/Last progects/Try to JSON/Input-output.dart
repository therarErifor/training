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

  String jsonCar = jsonEncode(tom);
  print(jsonCar);

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
}
