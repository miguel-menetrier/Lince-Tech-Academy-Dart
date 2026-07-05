void main(List<String> args) {
  var numeros = [3, 17, 23, 49, 328, 1358, 21, 429, 12, 103, 20021];

numeros.sort();
  for (var n in numeros) {
    var decimal = n;

    var binario = n.toRadixString(2);
    var octal = n.toRadixString(8);
    var hex = n.toRadixString(16);

    print(
      "Decimal : $decimal, Binario: $binario, Octal: ${octal.toString()}, Hexadecimal: ${hex.toString()}",
    );
  }
}
