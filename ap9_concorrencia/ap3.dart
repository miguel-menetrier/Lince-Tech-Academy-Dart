void main() async {
  print('Iniciando lançamento');

  for (var i = 10; i > 0; i--) {
    await Future.delayed(Duration(seconds: 1));
    print("Contagem regressiva: $i");
  }
  // todo: implementar contagem regressiva

  print('Foguete lançado!');
}
