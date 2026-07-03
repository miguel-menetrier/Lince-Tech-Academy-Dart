import 'dart:math';

void main(List<String> args) {
  final random = Random();
  final lista = List.generate(15, (generator) => random.nextInt(5000));

  imprimirValoresConvertidos(lista);
}

void imprimirValoresConvertidos(List<int> lista) {
  for (var i = 0; i < lista.length; i++) {
    final decimal = converterParaDecimal(lista[i]);
    final binario = converterParaBinario(lista[i]);
    final octal = converterParaOctal(lista[i]);
    final hex = converterParaHexadecimal(lista[i]);

    print(
      "Decimal: $decimal, Binario: $binario, Octal:  $octal, Hexadecimal: $hex ",
    );
  }
}

double converterParaDecimal(int valor) {
  return valor.toDouble();
}

String converterParaBinario(int valor) {
  return valor.toRadixString(2);
}

String converterParaOctal(int valor) {
  return valor.toRadixString(8);
}

String converterParaHexadecimal(int valor) {
  return valor.toRadixString(16);
}
