// NAO PODE SER MODIFICADO
// -------------------------------------------------------------
import 'dart:math' as math;

void main() {
  final meioDeComunicacao = aleatorio();
  meioDeComunicacao.fazerLigacao('(47) 99876-5432');
}

MeioDeComunicacao aleatorio() {
  final meiosDeComunicacao = <MeioDeComunicacao>[
    Telefone(),
    Celular(),
    Orelhao(),
  ];

  final random = math.Random();

  return meiosDeComunicacao[random.nextInt(meiosDeComunicacao.length)];
}

abstract class MeioDeComunicacao {
  void fazerLigacao(String telefone);
}

class Telefone implements MeioDeComunicacao {
  @override
  void fazerLigacao(String telefone) {
    print("[TELEFONE] Ligando para $telefone");
  }
}

class Celular implements MeioDeComunicacao {
  @override
  void fazerLigacao(String telefone) {
    print("[CELULAR] Ligando para $telefone");
  }
}

class Orelhao implements MeioDeComunicacao {
  @override
  void fazerLigacao(String telefone) {
    print("[ORELHAO] Ligando para $telefone");
  }
}
