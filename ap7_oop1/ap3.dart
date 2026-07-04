void main() {
  final produtos = [
    Produto("A", 30.0),
    Produto("B", 10.0),
    Produto("C", 10.0),
    Produto("D", 20.0),
    Produto("E", 35.0),
  ];

  for (final produto in produtos) {
    print(
      "Preço com desconto Produto ${produto.nome}: ${produto.aplicarDesconto(10)}",
    );
  }
}

class Produto {
  String nome;
  double preco;

  Produto(this.nome, this.preco);

  double aplicarDesconto(double percentual) {
    return preco - (preco * (percentual / 100));
  }
}