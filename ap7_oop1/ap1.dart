void main(List<String> args) {
  contaBancaria conta1 = contaBancaria("João", 1000);

  print("SALDO ATUAL: ${conta1.saldo}");

  conta1.depositar(500);
  print("SALDO ATUAL: ${conta1.saldo}");

  conta1.sacar(1000);
  print("SALDO ATUAL: ${conta1.saldo}");

  conta1.sacar(1000);
}

class contaBancaria {
  String titular;
  double saldo;

  contaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    saldo += valor;
  }

  void sacar(double valor) {
    if (valor <= saldo) {
      this.saldo -= valor;
    } else {
      ("Saldo insuficiente");
    }
  }
}
