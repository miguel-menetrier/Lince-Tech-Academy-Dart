# Guia de Controle de Fluxo em Dart: Condicionais e Laços de Repetição

Controlar a direção que o seu código toma e quantas vezes ele executa uma ação é o coração da lógica de programação. Em Dart, temos ferramentas robustas para estruturar essa tomada de decisões e repetições de forma limpa e performática.

---

## 1. Estruturas Condicionais: `if`, `else if` e `else`

O bloco `if` avalia uma condição booleana. Se for verdadeira (`true`), o código dentro dele é executado.

### Qual a diferença entre usar `if`, `else if` e `else`?

* **`if`**: É a porta de entrada. Avalia a primeira condição necessária.
* **`else if`**: Fornece caminhos alternativos **exclusivos**. Só é testado se todas as condições anteriores falharem. Você pode ter múltiplos `else if`.
* **`else`**: É o "porto seguro" ou o comportamento padrão. Só roda se **nenhuma** das condições anteriores for atendida.

```dart
void main() {
  var velocidade = 75;

  if (velocidade > 110) {
    print("Infração Grave!");
  } else if (velocidade > 80) {
    print("Infração Média!");
  } else {
    print("Velocidade permitida.");
  }
}

```

### ⚠️ Cuidados e organização com `if` e `else`

1. **Evite o "Código Pirâmide" (Aninhamento excessivo):** Colocar um `if` dentro de outro `if` várias vezes torna o código ilegível. Prefira usar cláusulas de guarda (*guard clauses*) ou operadores lógicos (`&&`, `||`).
2. **Organize por probabilidade ou severidade:** Coloque as condições mais específicas ou os erros críticos no topo.

---

## 2. Seleção Múltipla com `switch`

O `switch` avalia uma única expressão e compara seu valor com vários casos possíveis (`case`).

### Quando usar `switch` em vez de uma série de `if else`?

Use o `switch` quando você precisar comparar **uma mesma variável contra vários valores constantes e discretos**. Ele é mais limpo e legível do que encadear dez `else if`. O Dart suporta `switch` com inteiros, enums e até `String`.

```dart
void main() {
  var comando = 'CANCELAR';

  switch (comando) {
    case 'ABRIR':
      print("Abrindo o sistema...");
      break;
    case 'SALVAR':
      print("Salvando arquivos...");
      break;
    case 'CANCELAR':
      print("Operação cancelada.");
      break;
    default:
      print("Comando desconhecido.");
  }
}

```

### Qual a importância da palavra-chave `break` no `switch`?

No Dart clássico, se um `case` tiver código, você **obrigatoriamente** precisa terminar o bloco com `break`, `return` ou `throw`. O `break` avisa o programa para sair do `switch` assim que terminar aquele caso. Se você tentar deixar um `case` com código sem um comando de interrupção, o compilador do Dart gerará um erro, impedindo o comportamento de *fall-through* acidental (comum e problemático em linguagens como C e Java).

---

## 3. Laços de Repetição (`for` e `while`)

Os laços controlam quantas vezes um bloco de código deve se repetir.

### Quando usar `for` e quando usar `while`?

* **Use `for**` quando você **sabe exatamente quantas vezes** quer repetir ou quando está percorrendo uma coleção (como uma lista) de tamanho conhecido.
* **Use `while**` quando você **não sabe o número exato de repetições**, apenas que o código deve rodar *enquanto* uma condição externa for verdadeira.

### O loop `for` Tradicional vs `for...in`

* **`for` Tradicional:** Dá controle total sobre o índice. Ótimo para quando você precisa saber a posição atual ou pular elementos (ex: de 2 em 2).
* **`for...in`:** Muito mais limpo. Usado exclusivamente para iterar sobre coleções, entregando o elemento diretamente sem precisar gerenciar um contador.

```dart
void main() {
  // Repetir um número específico de vezes (ex: 3 vezes)
  for (var i = 0; i < 3; i++) {
    print("Contagem tradicional: $i");
  }

  // Iterando uma coleção de forma simplificada com for...in
  var frutas = ['Maçã', 'Banana', 'Laranja'];
  for (var fruta in frutas) {
    print("Fruta da vez: $fruta");
  }
}

```

### Os riscos do loop `while` sem condição de parada

Se a condição de um `while` nunca se tornar falsa, você cria um **loop infinito**. Isso trava a aplicação, consome toda a CPU e pode derrubar o sistema.

> **Exemplo conceitual (Simulando leitura de arquivos):**
> Um caso clássico de uso do `while` é ler linhas de um documento até que ele acabe.

```dart
// Exemplo simulado de leitura
class MockFileReader {
  int _linhasRestantes = 3;
  bool get temMaisLinhas => _linhasRestantes > 0;
  String lerLinha() {
    _linhasRestantes--;
    return "Conteúdo da linha";
  }
}

void main() {
  var leitor = MockFileReader();

  // Não sabemos quantas linhas o arquivo tem, apenas lemos enquanto houver dados
  while (leitor.temMaisLinhas) {
    print(leitor.lerLinha());
  }
}

```

---

## 4. Comandos de Interrupção (`break` e `continue`)

Eles servem para alterar o fluxo natural de um laço de repetição antes que a condição principal mude.

### Qual a diferença entre `break` e `continue`?

* **`break`**: Aborta o laço completamente. O programa pula para a primeira linha após o loop.
* **`continue`**: Interrompe apenas a iteração **atual**. O programa ignora o resto do código daquela volta e pula imediatamente para o próximo teste de condição do loop.

### Em quais situações o `continue` é útil?

Ele é excelente para filtrar ou ignorar dados inválidos no início do loop, evitando criar blocos `if` gigantescos ao redor de todo o resto do código.

```dart
void main() {
  var numeros = [1, 2, -3, 4, -5, 6];

  for (var n in numeros) {
    if (n < 0) continue; // Ignora números negativos e vai para o próximo
    print("Processando número positivo: $n");
  }
}

```

### Como usar `break` para sair de um loop aninhado? (Uso de Labels)

Se você tiver um loop dentro de outro e usar apenas o `break`, ele sairá apenas do loop interno. Para fechar ambos, você pode rotular (*label*) o loop externo.

```dart
void main() {
  // 'loopExterno' é o rótulo (label) dado ao laço de fora
  loopExterno: for (var i = 1; i <= 3; i++) {
    for (var j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        print("Condição crítica atingida. Parando tudo!");
        break loopExterno; // Quebra o loop principal, não apenas o interno
      }
      print("i: $i, j: $j");
    }
  }
}

```