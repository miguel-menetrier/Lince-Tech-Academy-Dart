import 'dart:math';

void main() {
  final pessoa = Pessoa();

  // OBJETIVO: escolher um fornecedor aleatório para cada refeição
  Fornecedor aleatorio() {
    final random = Random();

    final fornecedores = <Fornecedor>[
      FornecedorDeBebidas(),
      FornecedorDeSanduiches(),
      FornecedorDeBolos(),
      FornecedorDeSaladas(),
      FornecedorDePetiscos(),
      FornecedorDeUltracaloricos(),
    ];

    return fornecedores[random.nextInt(fornecedores.length)];
  }

  // OBJETIVO: simular refeições até o limite de tentativas
  for (var i = 0; i < 10; i++) {
    if (!pessoa.precisaComer()) break;
    pessoa.refeicao(aleatorio());
  }

  pessoa.informacoes();
}

abstract class Fornecedor {
  Produto fornecer();
}

class Produto {
  Produto(this.nome, this.calorias);

  /// Nome deste produto
  final String nome;

  /// Total de calorias
  final int calorias;
}

class FornecedorDeBebidas implements Fornecedor {
  final _random = Random();
  final _bebidasDisponiveis = <Produto>[
    Produto('Agua', 0),
    Produto('Refrigerante', 200),
    Produto('Suco de fruta', 100),
    Produto('Energetico', 135),
    Produto('Cafe', 60),
    Produto('Cha', 35),
  ];

  /// Retorna um produto que pode ser consumido por um consumidor
  @override
  Produto fornecer() {
    return _bebidasDisponiveis[_random.nextInt(_bebidasDisponiveis.length)];
  }
}

class FornecedorDeSanduiches implements Fornecedor {
  final _random = Random();
  final _sanduichesDisponiveis = <Produto>[
    Produto('Misto quente', 100),
    Produto('Hamburger', 500),
    Produto('Bauru', 200),
    Produto('Sanduiche de frango', 35),
  ];

  /// Retorna um produto que pode ser consumido por um consumidor
  @override
  Produto fornecer() {
    return _sanduichesDisponiveis[_random.nextInt(
      _sanduichesDisponiveis.length,
    )];
  }
}

class FornecedorDeBolos implements Fornecedor {
  final _random = Random();
  final _bolosDisponiveis = <Produto>[
    Produto('Bolo de cenoura', 150),
    Produto('Bolo de chocolate', 300),
    Produto('Bolo de fuba', 100),
    Produto('Bolo ingles', 100),
  ];

  /// Retorna um produto que pode ser consumido por um consumidor
  @override
  Produto fornecer() {
    return _bolosDisponiveis[_random.nextInt(_bolosDisponiveis.length)];
  }
}

class FornecedorDeSaladas implements Fornecedor {
  final _random = Random();
  final _saladasDisponiveis = <Produto>[
    Produto('Salada ceasar', 10),
    Produto('Salada grega', 15),
    Produto('Salada Waldorf', 30),
  ];

  /// Retorna um produto que pode ser consumido por um consumidor
  @override
  Produto fornecer() {
    return _saladasDisponiveis[_random.nextInt(_saladasDisponiveis.length)];
  }
}

class FornecedorDePetiscos implements Fornecedor {
  final _random = Random();
  final _petiscosDisponiveis = <Produto>[
    Produto('Batata frita', 120),
    Produto('Bolinha de queijo', 200),
    Produto('Coxinha', 100),
  ];

  /// Retorna um produto que pode ser consumido por um consumidor
  @override
  Produto fornecer() {
    return _petiscosDisponiveis[_random.nextInt(_petiscosDisponiveis.length)];
  }
}

class FornecedorDeUltracaloricos implements Fornecedor {
  final _random = Random();
  final _ultraCaloricosDisponiveis = <Produto>[
    Produto('Milkshake 700ml', 800),
    Produto('Pizza M&M', 500),
    Produto('Xis Tudo', 600),
  ];

  /// Retorna um produto que pode ser consumido por um consumidor
  @override
  Produto fornecer() {
    return _ultraCaloricosDisponiveis[_random.nextInt(
      _ultraCaloricosDisponiveis.length,
    )];
  }
}

enum StatusCalorico { deficitExtremo, deficit, satisfeita, excesso }

StatusCalorico calcularStatus(int calorias) {
  if (calorias <= 500) {
    return StatusCalorico.deficitExtremo;
  } else if (calorias <= 1800) {
    return StatusCalorico.deficit;
  } else if (calorias <= 2500) {
    return StatusCalorico.satisfeita;
  } else {
    return StatusCalorico.excesso;
  }
}

String _statusTexto(StatusCalorico status) {
  switch (status) {
    case StatusCalorico.deficitExtremo:
      return 'Déficit extremo de calorias';
    case StatusCalorico.deficit:
      return 'Déficit de calorias';
    case StatusCalorico.satisfeita:
      return 'Pessoa está satisfeita';
    case StatusCalorico.excesso:
      return 'Excesso de calorias';
  }
}

class Pessoa {

  int _caloriasConsumidas;
  int _refeicoes = 0;

  Pessoa() : _caloriasConsumidas = Random().nextInt(3000);

  void informacoes() {
    final status = calcularStatus(_caloriasConsumidas);

    print('--- Informações da Pessoa ---');
    print('Calorias consumidas: $_caloriasConsumidas');
    print('Refeições realizadas: $_refeicoes');
    print('Status: ${_statusTexto(status)}');
  }

  bool precisaComer() {
    final status = calcularStatus(_caloriasConsumidas);

    return status == StatusCalorico.deficitExtremo ||
        status == StatusCalorico.deficit;
  }

  void refeicao(Fornecedor fornecedor) {
    if (!precisaComer()) {
      print('Pessoa não precisa mais comer.');
      return;
    }

    final produto = fornecedor.fornecer();

    print('Consumindo ${produto.nome} (${produto.calorias} calorias)');

    _caloriasConsumidas += produto.calorias;
    _refeicoes++;
  }
}
