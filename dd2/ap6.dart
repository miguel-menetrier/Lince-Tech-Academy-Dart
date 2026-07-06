import 'dart:collection';

void main(List<String> args) {
  Baralho meuBaralho = Baralho();

  print('--- EMPILHANDO AS CARTAS NO BARALHO ---');
  // Incluindo as cartas na ordem especificada pelo enunciado
  meuBaralho.empilharCarta(Carta('A', Naipe.paus));
  meuBaralho.empilharCarta(Carta('A', Naipe.copas));
  meuBaralho.empilharCarta(Carta('A', Naipe.espadas));
  meuBaralho.empilharCarta(Carta('A', Naipe.ouros));

  print('\nTodas as cartas foram empilhadas com sucesso!\n');
  print('--------------------------------------------------\n');

  print('--- REMOVENDO AS CARTAS DO TOPO (LOOP) ---');
  // 2. Estrutura de repetição para remover uma por uma do topo até esvaziar
  while (meuBaralho.isNotEmpty) {
    meuBaralho.removerCarta();
  }

  print('\nO baralho está completamente vazio!');
  print('--------------------------------------------------');
}

enum Naipe {
  paus,
  copas,
  espadas,
  ouros;

  String get simbolo {
    switch (this) {
      case Naipe.paus:
        return '\u{2663}'; // ♣
      case Naipe.copas:
        return '\u{2665}'; // ♥
      case Naipe.espadas:
        return '\u{2660}'; // ♠
      case Naipe.ouros:
        return '\u{2666}'; // ♦
    }
  }
}

class Carta {
  Carta(this.valor, this.naipe);

  String valor;
  Naipe naipe;
}

class Baralho {
  Baralho();

  DoubleLinkedQueue<Carta> baralho = DoubleLinkedQueue<Carta>();
  bool get isNotEmpty => baralho.isNotEmpty;

  void empilharCarta(Carta carta) {
    baralho.addLast(carta);
    print("Carta empilhada");
  }

  void removerCarta() {
    if (baralho.isEmpty) {
      print("Baralho vazio");
    } else {
      baralho.removeLast();
      print("Carta removida");
    }
  }
}
