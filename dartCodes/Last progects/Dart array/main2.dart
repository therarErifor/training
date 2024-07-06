void main(){
  generate();
  fizzbuzztest();
}
List generate(){
  var list = [];
  for(int i = 1; i <= 100; i++){
    list.add(i);
  }
  print("Чистый массив: $list");
  return list;
}
void fizzbuzztest() {
  var list2 = generate();

  for (int i = 1; i < 100; i++){
    if (list2[i] % 3 == 0 && list2[i] % 5 == 0){
      list2[i] = "FizzBuzz";
    }
    else if (list2[i] % 3 == 0) {
      list2[i] = "Fizz";
    }
    else if (list2[i] % 5 == 0) {
      list2[i] = "Buzz";
    }
  }
  print("Измененный массив: $list2");
}

