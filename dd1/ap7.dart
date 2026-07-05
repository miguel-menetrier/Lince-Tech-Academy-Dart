void main(List<String> args) {
  var numeros = [10, 35, 999, 126, 95, 7, 348, 462, 43, 109];

  var resultado;

  resultado = somaFor(numeros);

  print("For: $resultado");

  resultado = somaWhile(numeros);

  print("While: $resultado");

  resultado = somaRecursiva(numeros, 0);

  print("Recursão:  $resultado");

  resultado = numeros.reduce((a, b) => a + b);

  print("Lista: $resultado");
}

int somaFor(List<int> lista) {
  var soma = 0;
  for (var numero in lista) {
    soma += numero;
  }

  return soma;
}

int somaWhile(List<int> lista) {
  var soma = 0;
  var contador = 0;
  while (contador != lista.length) {
    soma += lista[contador];
    contador++;
  }

  return soma;
}

int somaRecursiva(List<int> lista, int i) {
  if (i == lista.length) {
    return 0;
  }

  // Soma o elemento atual com o restante da lista
  return lista[i] + somaRecursiva(lista, i + 1);
}
