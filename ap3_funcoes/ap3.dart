import 'dart:math';

void main(List<String> args) {
  final random = Random();
  final listaDeRaios = List.generate(
    10,
    (item) => random.nextDouble() * 99 + 1,
  );

  for (var i = 0; i < listaDeRaios.length; i++) {
    print(
      "Raio: ${listaDeRaios[i].toStringAsFixed(2)} , area: ${calcularArea(listaDeRaios[i]).toStringAsFixed(2)}, perimetro: ${calcularPerimetro(listaDeRaios[i]).toStringAsFixed(2)}",
    );
  }
}

double calcularArea(double valorRaio) {
  const pi = 3.1415;

  final area = pi * pow(valorRaio, 2);
  return area;
}

double calcularPerimetro(double valorRaio) {
  const pi = 3.1415;

  final perimetro = 2 * pi * valorRaio;
  return perimetro;
}
