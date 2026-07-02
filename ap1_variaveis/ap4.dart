import 'dart:math';

void main(List<String> args) {
  final random = Random();

  final valor1 = random.nextInt(100);
  final valor2 = random.nextInt(100);

  final double divisao = valor1 / valor2;

  final int valorInteiro = divisao.floor();
  final double valorDecimal = divisao - valorInteiro;

  print("Valor 1 :$valor1");
  print("Valor 2 :$valor2");
  print("Resultado da divisão: $divisao");
  print("Valor inteiro: $valorInteiro");
  print("Valor decimal: $valorDecimal");
}
