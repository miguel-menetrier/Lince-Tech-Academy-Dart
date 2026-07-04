void main(List<String> args) {
  receberNumeroPar(5);
}

void receberNumeroPar(int numero) {
  try {
    numero.isOdd
        ? throw Exception()
        : print("Entrada correta, você inseriu um número par.");
  } catch (e) {
    print("Entrada inválida. Insira apenas números pares.");
  }
}
