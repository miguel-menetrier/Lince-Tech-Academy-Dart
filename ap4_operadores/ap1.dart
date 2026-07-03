void main(List<String> args) {
  final lista = [2000, 2014, 1993, 2016];

  for (var ano in lista) {
    print(ehAnoBissexto(ano) ? "${ano} é bissexto" : "${ano} não é bissexto");
  }
}

bool ehAnoBissexto(int ano) {
  if (ano.toString().endsWith("00")) {
    if (ano % 4 == 0 && ano % 400 == 0) {
      return true;
    }
  }
  if (ano % 4 == 0) {
    return true;
  }

  return false;
}
