void main(List<String> args) {
  final texto =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam venenatis nunc et posuere vehicula. Mauris lobortis quam id lacinia porttitor.";

  print("Texto: $texto");
  
  var numPalavras = texto.trim().split(" ").length;

  print("Numero de palavras: $numPalavras");

  var qtdLetras = texto.trim().codeUnits;

  print("Tamanho do texto: ${qtdLetras.length}");

  var qtdFrases = texto.split(". ");

  print("Quantidade de frases: ${qtdFrases.length}");

  var qtdVogais = 0;
  Set<String> setConsoantes = {};

  final vogais = ["a", "e", "i", "o", "u"];

  var texto2 = texto
      .trim()
      .replaceAll(" ", "")
      .replaceAll(".", "")
      .replaceAll(",", "");
  for (var i = 0; i < texto2.length; i++) {
    if (vogais.contains(texto2[i].toLowerCase())) {
      qtdVogais++;
    } else {
      setConsoantes.add(texto2[i].toLowerCase());
    }
  }

  List<String> listaConsoantes = setConsoantes.toList();

  listaConsoantes.sort();
  print("Quantidade de vogais : $qtdVogais");
  print("Consoantes: ${listaConsoantes.join(", ")}");
}
