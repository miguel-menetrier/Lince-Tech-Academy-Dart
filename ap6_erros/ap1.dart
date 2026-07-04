void main(List<String> args) {
  converterStringToInt("1.0");
}

void converterStringToInt(String numeroString) {
  final int numeroInt;
  try {
    numeroInt = int.parse(numeroString);
    print("Numero digitado: $numeroInt");
  } catch (e, s) {
    print("Entrada invalida. Digite apenas números inteiros.");
  }
}
