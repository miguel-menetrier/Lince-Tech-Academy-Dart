import 'dart:math';

void main(List<String> args) {
  final lista = [5, 8, 12, 7.3, 18, 2, 25];

  calcularAreaPerimetro(lista);
}

void calcularAreaPerimetro(List<num> listaDeRaios) {
  for (var raio in listaDeRaios) {
    const pi = 3.1415;
    var area = pi * pow(raio, 2);
    var perimetro = 2 * pi * raio;

    print("Raio: $raio , Area: ${area.toStringAsFixed(2)}, Perimetro: ${perimetro.toStringAsFixed(2)}");
  }
}
