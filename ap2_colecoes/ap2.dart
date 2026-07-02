import 'dart:math';

void main(List<String> args) {
  var random = Random();
  var lista = List.generate(50, (item) => random.nextInt(15));

  print("Lista original: $lista");

  lista.removeWhere((item) => item.isEven);

print("Lista atualizada: $lista");
}
