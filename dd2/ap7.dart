import 'dart:collection';
import 'dart:math';

void main(List<String> args) {
  Fila fila = Fila();
  for (var i = 0; i < 10; i++) {
    Pessoa p = GerarPessoaAleatoria.pessoaAleatoria();

    fila.pessoaEntrarNaFila(p);
  }

  print("--------------------");

  while (fila.isNotEmpty) {
    fila.antenderPessoaFila();
  }
}

class Fila {
  Fila();

  DoubleLinkedQueue<Pessoa> fila = DoubleLinkedQueue<Pessoa>();

  bool get isNotEmpty => fila.isNotEmpty;

  void pessoaEntrarNaFila(Pessoa pessoa) {
    fila.addLast(pessoa);

    print("${pessoa.nome} ${pessoa.sobrenome} entrou na fila");
  }

  void antenderPessoaFila() {
    if (fila.isEmpty) {
      print("Fila esta vazia");
    }
    print("${fila.first.nome} ${fila.first.sobrenome} foi atendido");

    fila.removeFirst();
  }
}

class Pessoa {
  Pessoa(this.nome, this.sobrenome);

  String nome;
  String sobrenome;
}

class GerarPessoaAleatoria {
  static Pessoa pessoaAleatoria() {
    final random = Random();
    List<String> nomes = [
      'Ana',
      'Francisco',
      'Joao',
      'Pedro',
      'Gabriel',
      'Rafaela',
      'Marcio',
      'Jose',
      'Carlos',
      'Patricia',
      'Helena',
      'Camila',
      'Mateus',
      'Gabriel',
      'Maria',
      'Samuel',
      'Karina',
      'Antonio',
      'Daniel',
      'Joel',
      'Cristiana',
      'Sebastião',
      'Paula',
    ];

    List<String> sobrenomes = [
      'Silva',
      'Ferreira',
      'Almeida',
      'Azevedo',
      'Braga',
      'Barros',
      'Campos',
      'Cardoso',
      'Teixeira',
      'Costa',
      'Santos',
      'Rodrigues',
      'Souza',
      'Alves',
      'Pereira',
      'Lima',
      'Gomes',
      'Ribeiro',
      'Carvalho',
      'Lopes',
      'Barbosa',
    ];

    return Pessoa(
      nomes[random.nextInt(nomes.length)],
      sobrenomes[random.nextInt(sobrenomes.length)],
    );
  }
}
