void main(List<String> args) {
  final lista = [1, 2, 3, 4, 5];

  print(lista);

  final novaLista = removerElemento(lista: lista, valorRemovido: 1);

  print(novaLista);
}

List<int> removerElemento({List<int>? lista, int? valorRemovido}) {
  lista?.remove(valorRemovido);

  return lista ?? [];
}
