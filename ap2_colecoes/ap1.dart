import 'dart:math';

void main(List<String> args) {
  
var lista = List<int>.filled(10, 0);   
var random = Random();
var valor;

for(int i = 0; i < 10; i++){

  valor = random.nextInt(100);

  lista[i] = valor;
  print("Posição : $i, valor ${lista[i]}");

  }
}