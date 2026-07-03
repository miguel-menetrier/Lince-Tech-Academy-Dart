import 'dart:math';

void main(List<String> args) {
  var random = Random();

  var lista1 = List.generate(5, (item) => random.nextInt(100));
  var lista2 = List.generate(5, (item) => random.nextInt(100));

  imprimirListaFormatada(lista1);

  var listaSomaDuasListas = somaValoresDuasListas(lista1, lista2);

  imprimirListaFormatada(listaSomaDuasListas);
}

void imprimirListaFormatada(List<int> lista) {
  if (lista.length > 0) {
    print("Lista: ${lista.join(", ")}");
  } else {
    print("Lista vazia");
  }
}

List<int> somaValoresDuasListas(List<int> lista1, List<int> lista2) {
  if (lista1.length != lista2.length) {
    return List.empty();
  }
  

  List<int> listaSomaDosValores = [];

  for (var i = 0; i < lista1.length; i++) {
    print("${lista1[i]} + ${lista2[i]}");
    listaSomaDosValores.add(lista1[i] + lista2[i]);
  }

  return listaSomaDosValores;
}
