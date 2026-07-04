# Guia de Programação Orientada a Objetos (POO) em Dart

A Programação Orientada a Objetos (POO) é um paradigma de programação que utiliza "objetos" para representar dados e comportamentos do mundo real. Em Dart, a POO é a base de tudo, inclusive do framework Flutter.

Abaixo está a documentação detalhada dos principais conceitos de POO em Dart, explicados por meio de um cenário real: um **Sistema de Pagamentos Eletrônicos**.

---

## 1. Herança e Sobrescrita de Métodos

### O que é Herança e como funciona?

A **Herança** é um mecanismo que permite que uma classe (chamada classe filha ou subclasse) herde atributos e métodos de outra classe (chamada classe pai ou superclasse). Isso evita a duplicação de código e estabelece uma relação do tipo *"é um"*. Em Dart, utilizamos a palavra-chave `extends`.

### O que significa "sobrescrever" um método?

Sobrescrever (`@override`) significa reescrever, na classe filha, um método que já foi definido na classe pai. Fazemos isso quando o comportamento geral da classe pai precisa ser especializado para a classe filha.

### Herança vs. Composição

* **Herança ("É um"):** Uma `ContaCorrente` *é uma* `ContaBancaria`. Ela herda tudo automaticamente.
* **Composição ("Tem um"):** Uma `ContaBancaria` *tem um* `HistoricoDeTransacoes`. Em vez de herdar, a classe possui uma instância de outro objeto como atributo. A composição é geralmente mais flexível que a herança.

### Exemplo Prático

No exemplo abaixo, veja como a classe `ContaCorrente` herda de `ContaBancaria`, altera o comportamento do método `sacar` e utiliza o termo `super` para chamar o método original da classe pai.

```dart
// Classe Pai (Superclasse)
class ContaBancaria {
  double saldo;

  ContaBancaria(this.saldo);

  void sacar(double valor) {
    if (valor <= saldo) {
      saldo -= valor;
      print("Saque de R\$ $valor realizado com sucesso.");
    } else {
      print("Saldo insuficiente.");
    }
  }
}

// Classe Filha (Subclasse)
class ContaCorrente extends ContaBancaria {
  double limiteChequeEspecial;

  ContaCorrente(double saldoInicial, this.limiteChequeEspecial) : super(saldoInicial);

  // Sobrescrevendo o método da classe pai para incluir o cheque especial
  @override
  void sacar(double valor) {
    double saldoTotalDisponivel = saldo + limiteChequeEspecial;

    if (valor <= saldoTotalDisponivel) {
      saldo -= valor; // O saldo pode ficar negativo aqui
      print("Saque de R\$ $valor realizado (Uso de limite permitido).");
    } else {
      // Como posso chamar o método original da classe pai? Usando 'super'
      print("Tentativa de saque falhou.");
      super.sacar(valor); 
    }
  }
}

```

---

## 2. Getters e Setters

### Por que usar em vez de acessar atributos diretamente?

Acessar atributos diretamente expõe os dados internos da classe sem nenhuma proteção. O uso de **Getters e Setters** garante o **Encapsulamento**, permitindo:

1. **Validação:** Impedir que dados inválidos (como um saldo negativo) sejam inseridos.
2. **Segurança:** Tornar atributos apenas de leitura para o mundo exterior.
3. **Propriedades Computadas:** Modificar o dado antes de entregá-lo ou calculá-lo em tempo real.

Em Dart, atributos privados começam estritamente com um sublinhado (`_`).

### Exemplo Prático (Validação e Atributo Privado)

```dart
class Usuario {
  String _cpf = ""; // Atributo privado
  double _saldoConstante = 100.0;

  // Como criar um getter para acessar um atributo privado
  String get cpf => _cpf;

  // Como criar um setter com validação para modificar o atributo privado
  set cpf(String novoCpf) {
    if (novoCpf.length == 11) {
      _cpf = novoCpf;
    } else {
      print("Erro: CPF inválido! Deve conter exatamente 11 dígitos.");
    }
  }

  // Exemplo de Getter Computado (Apenas leitura, sem setter)
  double get saldoEmDolar => _saldoConstante / 5.20; 
}

```

---

## 3. Classes Abstratas

### O que é uma classe abstrata e qual a diferença para uma normal?

Uma **Classe Abstrata** serve como um molde/modelo para outras classes. A principal diferença é que **ela não pode ser instanciada diretamente** (você não pode dar um `new` ou chamar o construtor dela para criar um objeto). Ela pode conter tanto métodos normais (com corpo) quanto **métodos abstratos** (apenas a assinatura, sem corpo), que obrigam as classes filhas a implementá-los.

### Quando usar?

Use classes abstratas quando você tem um conceito geral que não deve existir sozinho no sistema, mas que define a estrutura de subconceitos reais. Por exemplo: você não tem um "Pagamento" genérico na vida real, você tem um "PagamentoComCartao" ou "PagamentoComPix".

### Exemplo Prático

```dart
// Classe Abstrata: não pode ser instanciada diretamente
abstract class Transacao {
  double valor;
  DateTime data;

  Transacao(this.valor, this.data);

  // Método abstrato: não tem corpo, as classes filhas SÃO OBRIGADAS a criar
  void processarTransacao();

  // Método concreto: pode ser herdado normalmente pelas filhas
  void emitirComprovante() {
    print("Comprovante gerado para o valor de R\$ $valor em $data");
  }
}

class PagamentoPix extends Transacao {
  String chavePix;

  PagamentoPix(double valor, DateTime data, this.chavePix) : super(valor, data);

  @override
  void processarTransacao() {
    print("Conectando ao Banco Central... Pix enviado para a chave: $chavePix.");
  }
}

```

---

## 4. Definindo Contratos de Comportamento (Interfaces)

### O que é uma Interface em Dart?

Em muitas linguagens existe a palavra-chave `interface`. **Em Dart, isso não existe.** Toda classe define, implicitamente, uma interface. Para criar uma interface em Dart, criamos uma classe normal (ou abstrata) e usamos a palavra-chave `implements` em vez de `extends`.

### Diferença entre Herança (`extends`) e Interface (`implements`)

* **Herança (`extends`):** A classe filha herda a estrutura e o comportamento do pai. Existe reuso de código. Permite apenas uma herança por classe.
* **Interface (`implements`):** A classe não herda nada do código interno. Ela apenas assina um **contrato** prometendo que vai recriar do zero todos os métodos e atributos daquela interface. Permite implementar múltiplas interfaces de uma vez.

### Exemplo Prático

```dart
// Definindo o contrato de comportamento
abstract class Autenticavel {
  bool login(String senha);
}

abstract class Notificavel {
  void enviarNotificacao(String mensagem);
}

// Uma classe pode implementar múltiplos contratos de comportamento
class GerenteFinanceiro implements Autenticavel, Notificavel {
  @override
  bool login(String senha) {
    return senha == "admin123";
  }

  @override
  void enviarNotificacao(String mensagem) {
    print("SMS enviado ao gerente: $mensagem");
  }
}

```

---

## 5. Enumeradores (Enums)

### O que são e para que servem?

**Enumeradores (Enums)** são tipos de dados especiais usados para representar um conjunto fixo de valores constantes que não mudam. Eles tornam o código mais seguro, legível e evitam erros de digitação.

### Quando usar Enums em vez de constantes normais?

Use enums quando você tem uma lista predefinida de opções mutáveis. Se você usar `String` ou `int` para representar estados, qualquer programador pode digitar `"PAGuO"` em vez de `"PAGO"`, gerando bugs. O Enum força o uso exclusivo das opções válidas em tempo de compilação.

### Exemplo Prático

```dart
enum StatusPagamento {
  pendente,
  aprovado,
  recusado,
  estornado
}

class Pedido {
  double total;
  StatusPagamento status; // Uso do Enum

  Pedido(this.total, this.status);

  void atualizarStatus() {
    switch (status) {
      case StatusPagamento.pendente:
        print("Aguardando confirmação do banco.");
        break;
      case StatusPagamento.aprovado:
        print("Produto liberado para envio!");
        break;
      case StatusPagamento.recusado:
        print("Operação negada pela operadora do cartão.");
        break;
      case StatusPagamento.estornado:
        print("Dinheiro devolvido ao cliente.");
        break;
    }
  }
}

```

---

## 6. Métodos Estáticos ou Métodos de Classe

### O que são e como diferem dos métodos de instância?

* **Métodos de Instância:** Precisam que você crie um objeto usando `v = Classe()` para poder chamá-los. Eles operam em dados que pertencem àquela instância específica.
* **Métodos Estáticos (`static`):** Pertencem à **classe em si**, e não aos objetos criados por ela. Eles não conseguem acessar variáveis de instância que não sejam estáticas.

### Quando utilizar?

Use métodos estáticos para funções utilitárias ou operações auxiliares que realizam tarefas gerais que não dependem do estado interno de nenhum objeto específico.

### Como acessar sem criar uma instância?

Basta chamar diretamente pelo nome da classe: `NomeDaClasse.nomeDoMetodo();`

### Exemplo Prático

```dart
class CalculadoraFinanceira {
  // Atributo estático (compartilhado por toda a classe)
  static double taxaIoF = 0.0438;

  // Método estático: Não precisa de 'new' ou instância para ser executado
  static double calcularImpostoSobreOperacao(double valorTransacao) {
    return valorTransacao * taxaIoF;
  }
}

void main() {
  // Acessando o método diretamente através da classe, sem instanciar nada
  double imposto = CalculadoraFinanceira.calcularImpostoSobreOperacao(1000.0);
  print("O valor do imposto cobrado será: R\$ $imposto");
}

```

---

## Tabela Resumo dos Conceitos

| Conceito | Palavra-chave | Objetivo Principal | Pode Instanciar? |
| --- | --- | --- | --- |
| **Herança** | `extends` | Reutilizar código e estender comportamentos. | Sim (da classe filha). |
| **Getters/Setters** | `get` / `set` | Proteger dados privados da classe (Encapsulamento). | N/A |
| **Classe Abstrata** | `abstract` | Criar moldes/modelos estruturais obrigatórios. | **Não**. |
| **Interface** | `implements` | Definir um contrato rígido de comportamentos obrigatórios. | Sim (da classe que implementa). |
| **Enum** | `enum` | Criar um grupo de constantes fixas e seguras. | Não da forma tradicional. |
| **Método Estático** | `static` | Criar funções utilitárias ligadas diretamente à Classe. | N/A |