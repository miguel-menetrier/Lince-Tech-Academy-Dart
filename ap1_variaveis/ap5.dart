

void main(List<String> args) {
  const pessoa = Pessoa("João", "Silva", 30, true, 81.3, "Brasileiro");
  print(pessoa.toString());
}

class Pessoa {
  final String nome;
  final String sobrenome;
  final int idade;
  final bool ativo;
  final double peso;
  final String? nacionalidade;

  const Pessoa(
    this.nome,
    this.sobrenome,
    this.idade,
    this.ativo,
    this.peso,
    this.nacionalidade,
  );

@override
String toString() {

var imprimirFormatado = "";
imprimirFormatado += "Nome completo: $nome $sobrenome\n";

    if (idade >= 18) {
      imprimirFormatado += "Idade: $idade (maior de idade)\n";
    } else {
      imprimirFormatado += "Idade: $idade (menor de idade)\n";
    }

    if (ativo) {
      imprimirFormatado += "Situação: Ativo\n";
    } else {
      imprimirFormatado += "Situação: Inativo\n";
    }

    imprimirFormatado += "Peso: ${peso.toStringAsFixed(2)}\n";

    if (nacionalidade != null) {
      imprimirFormatado += "Nacionalidade: $nacionalidade\n";
    } else {
      imprimirFormatado += "Nacionalidade: Nao informada\n";
    }

    return imprimirFormatado;
  }


}
