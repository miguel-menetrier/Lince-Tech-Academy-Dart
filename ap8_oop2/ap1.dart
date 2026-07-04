import 'dart:math';

enum GenerosMusicais { trap, pagode, samba, rock, pop, rap }

void main(List<String> args) {
  final random = Random();

  final generos = GenerosMusicais.values;


  print("Meu genero musical favorito é: ${generos[random.nextInt(6)].name}");
}
