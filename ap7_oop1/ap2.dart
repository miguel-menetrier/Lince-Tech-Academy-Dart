void main(List<String> args) {
  Retangulo retangulo = Retangulo(10, 20);

  retangulo.calcularArea();
}

class Retangulo {
  double altura;
  double largura;

  Retangulo(this.altura, this.largura);

  void calcularArea() {
    final area = this.altura * this.largura;

    print("Area do retangulo $area");
  }
}
