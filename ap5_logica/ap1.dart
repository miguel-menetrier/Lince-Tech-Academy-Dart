void main(List<String> args) {
  final tamanho = 10;

  final listaDeNumeros = criarListaDeNumeros(tamanho);

  for (var numero in listaDeNumeros) {

    if(numero.isOdd){
      print("Impar: $numero");
    }


  }
}

List<int> criarListaDeNumeros(int tamanho) {
  final listaDeNumeros = <int>[];
  for (var i = 0; i < tamanho; i++) {
    listaDeNumeros.add(i);
  }

  return listaDeNumeros;
}
