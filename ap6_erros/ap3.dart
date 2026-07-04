import 'dart:math';

void main(List<String> args) {
  try {
    final random = Random();

    final base = random.nextDouble() * 99;
    final altura = random.nextDouble() * 99;

    final retangulo = Retangulo(base, altura);

    final areaRetangulo = retangulo.calcularArea();
    print("Area do retangulo : ${areaRetangulo}");
  } on Exception catch (e) {
    print(e);
  }
}

abstract class Forma {
  double calcularArea();
}

class Retangulo implements Forma {
  Retangulo(this.base, this.altura) {
    if (base <= 0 || altura <= 0) {
      throw Exception(
        "Dimensoes invalidas, informe apenas valores positivos maiores que zero",
      );
    }
  }

  final double base;
  final double altura;

  @override
  double calcularArea() {
    return base * altura;
  }
}
