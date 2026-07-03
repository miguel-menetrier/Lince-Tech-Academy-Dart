void main(List<String> args) {
  final textos = [
    '10',
    '2XXL7',
    'JOJ0',
    '99',
    '381',
    'AD44',
    '47',
    '2B',
    '123',
    '78',
  ];

  final listaConvertida = converterTextoParaNumero(textos);
  print("Lista convertida: ${listaConvertida.join(" ,")}");
}

List<int> converterTextoParaNumero(List<String> listaTexto) {
  final listaConvertida = <int>[];

  for (var texto in listaTexto) {
    int? valorConvertido = int.tryParse(texto);

    valorConvertido ??= 0;

    listaConvertida.add(valorConvertido);
  }
  return listaConvertida;
}
