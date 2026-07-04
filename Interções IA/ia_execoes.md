# Tratamento de Exceções em Dart: Guia Completo

---

## 1. Erros vs. Exceções: Qual a diferença?

Em Dart, tanto os **Erros (Errors)** quanto as **Exceções (Exceptions)** representam problemas que ocorrem durante a execução do código, mas eles têm propósitos, causas e tratamentos bem diferentes.

### O que é um Erro (Error)?

* **Definição:** Indica falhas graves do programa ou erros de lógica cometidos pelo desenvolvedor que **não deveriam acontecer** se o código estivesse correto.
* **Quando esperar:** Falhas de memória (`OutOfMemoryError`), passagem de argumentos inválidos detectados em tempo de execução (`ArgumentError`), ou tentativas de acessar um índice fora dos limites de uma lista (`RangeError`).
* **Comportamento:** Geralmente, os erros **não devem ser capturados** (`catch`). Eles servem para avisar o desenvolvedor de que há um bug estrutural que precisa ser corrigido diretamente no código.

### O que é uma Exceção (Exception)?

* **Definição:** Indica condições operacionais e de fluxo que um programa bem escrito pode antecipar e, idealmente, se recuperar. Elas representam problemas externos ou imprevistos, não necessariamente bugs de lógica.
* **Quando esperar:** Falhas de conexão com a internet (`NetworkException`), problemas ao ler um arquivo corrompido, ou tentar converter uma string inválida em número (`FormatException`).
* **Comportamento:** Devem ser capturadas e tratadas para evitar que o aplicativo trave (crash) na mão do usuário final.

---

## 2. O Uso do `assert` no Desenvolvimento

O `assert` (asserção) é uma ferramenta de validação condicional usada **exclusivamente durante o desenvolvimento** (modo de depuração/debug).

### Como funciona e quando usar?

O `assert` interrompe a execução do programa imediatamente se a condição testada for **falsa**. Ele é extremamente útil para garantir que contratos de código (como pré-requisitos de funções) sejam respeitados pela equipe de desenvolvimento.

```dart
void configurarIdade(int idade) {
  // Se a idade for negativa, o programa para aqui durante os testes
  assert(idade >= 0, 'A idade não pode ser negativa!');
  print('Idade configurada para: $idade');
}

```

### `assert` vs. Lançar Exceções

* **`assert`:** É completamente ignorado no modo de produção (quando o app é compilado para os usuários). Serve apenas para o desenvolvedor pegar bugs cedo.
* **Lançar Exceção:** Funciona tanto em desenvolvimento quanto em produção. Deve ser usada para validações de dados reais e dinâmicos que podem falhar no dia a dia do usuário (como validar se um e-mail digitado possui "@").

---

## 3. Tratamento de Exceções com `try`, `catch` e `finally`

Para evitar que uma exceção interrompa o aplicativo abruptamente, estruturamos blocos de captura de fluxo.

### O papel de cada bloco:

* **`try`:** Envolve o código "perigoso", ou seja, o bloco onde você sabe que uma exceção pode vir a acontecer (ex: uma requisição HTTP).
* **`catch`:** Captura a exceção caso ela ocorra dentro do bloco `try`, permitindo que você trate o problema de forma amigável (ex: exibindo um aviso na tela).
* **`finally`:** Bloco opcional que **sempre** será executado, ocorrendo um erro ou não. É ideal para limpar recursos, fechar arquivos ou encerrar conexões com o banco de dados.

### Capturando diferentes tipos de exceções (`on` e `catch`)

Em Dart, você pode filtrar e capturar exceções específicas usando a palavra-chave `on` antes do `catch`. Isso permite dar respostas personalizadas para problemas diferentes.

```dart
try {
  // Simulando operações que podem falhar
  int resultado = 12 ~/ 0; 
} on UnsupportedError {
  print('Erro específico: Não é possível dividir por zero!');
} on FormatException catch (e) {
  print('Erro de formato: ${e.message}');
} catch (e, s) {
  // Captura qualquer outra exceção que não foi mapeada acima
  print('Ocorreu um erro desconhecido: $e');
  print('Rastro da pilha (Stack Trace): $s');
} finally {
  print('Esta linha sempre será executada, limpando recursos.');
}

```

> **Nota:** O segundo parâmetro opcional do `catch` (geralmente chamado de `s` ou `stackTrace`) funciona como um histórico ou mapa que mostra exatamente em quais linhas do código o erro navegou até estourar.

---

## 4. Lançando Exceções (`throw`)

Você deve lançar uma exceção quando seu código encontra uma situação em que ele não consegue prosseguir com o fluxo normal e precisa delegar a responsabilidade do problema para quem chamou aquela função.

### Por que e como lançar?

Embora o Dart permita lançar qualquer objeto não nulo (`throw 'Erro!';`), a boa prática recomenda lançar instâncias de classes que implementam `Exception` ou `Error`.

```dart
void processarPagamento(double valor) {
  if (valor <= 0) {
    throw Exception('O valor do pagamento deve ser maior que zero.');
  }
  print('Processando R\$ $valor...');
}

```

### Como personalizar mensagens?

Você pode criar suas próprias exceções customizadas implementando a classe `Exception`. Isso deixa o sistema muito mais semântico.

```dart
class SaldoInsuficienteException implements Exception {
  final double saldoAtual;
  final double valorTentado;

  SaldoInsuficienteException(this.saldoAtual, this.valorTentado);

  @override
  String toString() => 
      'SaldoInsuficienteException: Tentativa de sacar R\$ $valorTentado com saldo de apenas R\$ $saldoAtual.';
}

// Implementação prática
void sacar(double valor, double saldo) {
  if (valor > saldo) {
    throw SaldoInsuficienteException(saldo, valor);
  }
}

```

---

## 5. Melhores Práticas e Organização no Projeto

### Como organizar suas exceções?

1. **Centralize por domínios:** Em projetos maiores, crie arquivos de exceções dentro das pastas de suas funcionalidades (ex: `features/auth/domain/errors/auth_exceptions.dart`).
2. **Use uma classe base:** Crie uma classe abstrata comum (como `Failure` ou `AppException`) para que todas as suas exceções customizadas herdem dela. Isso facilita criar um único interceptador de erros na interface do usuário.

### Como erros e exceções afetam a execução do programa?

* **Fluxo de uma Exceção Não Tratada:** Se uma exceção não for capturada por nenhum bloco `try/catch`, ela "sobe" pela pilha de chamadas das funções até chegar na função `main()`. Se ninguém a tratar ali, a thread atual é interrompida. No Flutter, isso pode gerar a famosa tela cinza/vermelha em desenvolvimento ou fazer o aplicativo fechar sozinho no celular do usuário.
* **Fluxo de um Erro:** Interrompe imediatamente o fluxo para expor a falha de código, garantindo que o estado corrompido do app não continue rodando e cause estragos maiores (como salvar dados errados no banco).

---

Qual dessas partes você gostaria de aprofundar criando um exemplo prático focado na arquitetura do seu projeto atual?