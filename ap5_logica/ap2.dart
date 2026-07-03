import 'dart:math';

void main(List<String> args) {
  final random = Random();

  for (var i = 0; i < 5; i++) {
    final numero = random.nextInt(25) + 1;

    final letra = letraNumero(numero);

    print("Numero: $numero - Letra: $letra");
  }

  print(letraNumero(0));
}

String letraNumero(int numero) {
  final alfabeto = [
    '',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  return alfabeto[numero];
}
