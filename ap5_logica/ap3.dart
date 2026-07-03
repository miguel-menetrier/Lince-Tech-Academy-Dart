import 'dart:math';

void main(List<String> args) {
  final random = Random();
  final tamanho = random.nextInt(900) + 100;

  somaNumerosPares(tamanho);

  
}

void somaNumerosPares(int tamanho) {
  var soma = 0;
  for (var i = 1; i <= tamanho; i++) {
    if (i.isEven) {
      soma += i;
    }
  }

  print("Soma dos numeros pares de 0 a $tamanho: $soma");
}
