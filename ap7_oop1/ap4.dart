import 'dart:math';

void main(List<String> args) {
  final random = Random();

  Pessoa pessoa1 = Pessoa();

  pessoa1.nome = "Joao";
  pessoa1.idade = random.nextInt(99) + 1;
  pessoa1.altura = (random.nextDouble() * 1.3) + 1;

  print("Nome: ${pessoa1.nome}");
  print("Idade: ${pessoa1._idade}");
  print("Altura: ${pessoa1._altura}");


}

class Pessoa {
  late String _nome;
  late int _idade;
  late double _altura;

  String get nome => _nome;

  set nome(String valor) {
    _nome = valor;
  }

  int get idade => _idade;

  set idade(int valor) {
    if (valor >= 0) {
      _idade = valor;
    } else{
      print("Idade deve ser maior ou igual a zero");
    }
  }

  double get altura => _altura;

  set altura(double valor) {
    if (valor > 0) {
      _altura = valor;
    }
  }
}
