import 'dart:math';

void main(List<String> args) {
  final random = Random();

  var num1 = random.nextInt(100);
  var num2 = random.nextInt(100);

  print("Valor num1 : $num1");
  print("Valor num2 : $num2");

  var valorNum1 = num1;

  num1 = num2;

  num2 = valorNum1;

  print("Valor num1 : $num1");
  print("Valor num2 : $num2");
}
