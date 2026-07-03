void main(List<String> args) {
  final double valorProduto = 100;
  final double valorVendido = 70;

  print("Valor produto: $valorProduto");
  print("Valor vendido: $valorVendido");
  print("Desconto: ${porcentoDesconto(valorProduto, valorVendido)}%");
}

int porcentoDesconto(double valorProduto, double valorVendido) {
  final desconto = (valorVendido * 100) ~/ valorProduto;

  return 100 - desconto;
}
