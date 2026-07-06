void main() {
  final controleDePessoas = ControleDePessoas();

  // Cadastrando pessoas no sistema
  controleDePessoas
    ..cadastrarPessoa(Pessoa('Jose', Mes.abril))
    ..cadastrarPessoa(Pessoa('Arthur', Mes.agosto))
    ..cadastrarPessoa(Pessoa('Joao', Mes.abril))
    ..cadastrarPessoa(Pessoa('Jesse', Mes.dezembro))
    ..cadastrarPessoa(Pessoa('Roberta', Mes.fevereiro))
    ..cadastrarPessoa(Pessoa('Carla', Mes.fevereiro))
    ..cadastrarPessoa(Pessoa('Thania', Mes.agosto))
    ..cadastrarPessoa(Pessoa('Rafaela', Mes.marco))
    ..cadastrarPessoa(Pessoa('Yuri', Mes.junho))
    ..cadastrarPessoa(Pessoa('Jonas', Mes.setembro))
    ..cadastrarPessoa(Pessoa('Elias', Mes.outubro))
    ..cadastrarPessoa(Pessoa('Abel', Mes.maio))
    ..cadastrarPessoa(Pessoa('Danilo', Mes.abril))
    ..cadastrarPessoa(Pessoa('Jonathan', Mes.abril))
    ..cadastrarPessoa(Pessoa('Joseph', Mes.setembro))
    ..cadastrarPessoa(Pessoa('Abdul', Mes.janeiro))
    ..cadastrarPessoa(Pessoa('Jean', Mes.abril));

  // Passar por todos os meses com pessoas, e imprimir os nomes das pessoas
  for (final mes in controleDePessoas.mesesComPessoas) {
    print('\n${mes.name}');

    for (final pessoa in controleDePessoas.pessoasPorMes(mes)) {
      print(' > ${pessoa.nome}');
    }
  }
}

enum Mes {
  janeiro,
  fevereiro,
  marco,
  abril,
  maio,
  junho,
  julho,
  agosto,
  setembro,
  outubro,
  novembro,
  dezembro,
}

class Pessoa {
  Pessoa(this.nome, this.mesDeNascimento);

  final String nome;
  final Mes mesDeNascimento;
}

class ControleDePessoas {
  // Alterado para um mapa onde agrupamos a lista de pessoas usando o Mês como chave
  final Map<Mes, List<Pessoa>> _pessoasPorMes = {};

  /// Cadastra uma pessoa no sistema organizando-a diretamente no seu respectivo mês
  void cadastrarPessoa(Pessoa pessoa) {
    // .putIfAbsent garante que se o mês não tiver nenhuma lista criada ainda,
    // ele inicializa uma lista vazia antes de dar o .add
    _pessoasPorMes.putIfAbsent(pessoa.mesDeNascimento, () => []).add(pessoa);
  }

  /// Retorna os meses com pessoas cadastradas organizados cronologicamente
  List<Mes> get mesesComPessoas {
    // Como as chaves do mapa já são os meses que contêm pessoas, eliminamos o loop de verificação!
    final listaMeses = _pessoasPorMes.keys.toList();

    // Ordena os meses conforme a ordem natural do enum (cronológica)
    return listaMeses..sort((a, b) => a.index.compareTo(b.index));
  }

  /// Retorna a lista de pessoas que nasceram no [mes] especificado de forma instantânea (O(1))
  List<Pessoa> pessoasPorMes(Mes mes) {
    // Retorna a lista pronta direto do mapa. Se o mês não existir no mapa, retorna uma lista vazia.
    return _pessoasPorMes[mes] ?? [];
  }
}
