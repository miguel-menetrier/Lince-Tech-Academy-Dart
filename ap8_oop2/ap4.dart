import 'dart:math';

void main(List<String> args) {
  final int valor = Random().nextInt(100);

  final valorDobrado = Caluladora.dobro(valor);

  print("O dobro de $valor : $valorDobrado");
}

abstract class Caluladora {
  static int dobro(int valor) {
    return valor * 2;
  }
}
