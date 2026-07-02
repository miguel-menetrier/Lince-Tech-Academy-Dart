import 'dart:math';

void main(List<String> args) {
  var random = Random();
  var lista = List.generate(50, (item) => random.nextInt(10) + 12);

  print("Lista original: $lista");

  Set<int> listaUnica = lista.toSet();
  print("Lista única: $listaUnica");
}