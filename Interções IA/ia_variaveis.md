
# Guia de Referência: Variáveis em Dart

Esta documentação fornece uma visão detalhada sobre como declarar, inicializar e gerenciar variáveis na linguagem Dart, seguindo as diretrizes oficiais de design e boas práticas.

---

## 1. Trabalhando com Variáveis

Em Dart, você pode criar uma variável de duas formas principais: deixando o Dart inferir o tipo automaticamente através da palavra-chave `var`, ou declarando o tipo de forma explícita.

```dart
// Inferência de tipo (Recomendado para variáveis locais)
var nome = 'Dart'; 

// Declaração explícita de tipo
String linguagem = 'Dart'; 

```

### Boas Práticas ao Declarar Variáveis

* **Use `var` para variáveis locais:** Se o tipo for óbvio pelo valor de inicialização, prefira `var`. Isso mantém o código limpo e legível.
* **Siga o padrão `lowerCamelCase`:** Nomes de variáveis devem começar com letra minúscula e capitalizar as palavras seguintes (ex: `userName`, `totalPrice`).
* **Prefira tipos explícitos em assinaturas públicas:** Para propriedades de classes, parâmetros de funções e retornos de métodos, declare o tipo explicitamente para servir como documentação.

### O que Evitar

* **Evite o uso excessivo de `dynamic`:** O tipo `dynamic` desativa a checagem estática de tipos do Dart. Use-o apenas se a variável realmente puder receber múltiplos tipos completamente diferentes ao longo da execução.
* **Evite redundâncias:** Não declare o tipo se você já está instanciando o objeto logo em seguida.
```dart
// EVITE (Redundante)
List<String> nomes = <String>[];

// PREFIRA
var nomes = <String>[];
// OU
List<String> nomes = [];

```



---

## 2. Variáveis e Valores Padrão (Null Safety)

O Dart possui um sistema de **Null Safety** (segurança nula de sombreado). Isso significa que, por padrão, as variáveis não podem conter o valor `null`, a menos que você diga explicitamente ao compilador que isso é permitido.

Para permitir que uma variável seja nula, adicione o sufixo `?` ao tipo:

```dart
int? count; // Inicializa automaticamente como null
print(count); // Saída: null

// int contador; // ERRO DE COMPILAÇÃO: Deve ser inicializada antes do uso

```

### Cuidados ao Criar Variáveis com Valor Nulo

Ao trabalhar com tipos anuláveis (`Type?`), você deve garantir que o valor não é nulo antes de acessar suas propriedades ou métodos.

* Use o operador de navegação segura (`?.`) para evitar exceções em tempo de execução: `print(count?.isEven);`
* Use o operador de coalescência nula (`??`) para fornecer um valor padrão: `int resultado = count ?? 0;`
* **Evite o uso indiscriminado do operador `!` (bang):** O operador `!` força o Dart a tratar a variável como não-nula. Se ela estiver nula, o programa lançará um erro fatal em tempo de execução (`TypeError`).

---

## 3. O Modificador `late`

O modificador `late` é utilizado para declarar variáveis que **não são nulas**, mas cuja inicialização ocorrerá **após** a sua declaração.

```dart
class Descricao {
  late String conteudo;

  void inicializar() {
    conteudo = 'Documentação oficial do Dart';
  }
}

```

### Quando usar variáveis nulas vs. Modificador `late`?

* **Use variáveis nulas (`?`)** quando a ausência de valor for uma condição válida e esperada durante o ciclo de vida do programa (ex: um campo de formulário opcional).
* **Use `late**` quando você tem certeza absoluta de que a variável será inicializada antes do primeiro acesso, mas o compilador não consegue deduzir isso sozinho (ex: inicializações dentro do `initState` no Flutter).

### Benefícios do `late`

1. **Satisfaz o Null Safety:** Permite que variáveis de instância não-nulas não precisem ser inicializadas diretamente no construtor.
2. **Inicialização Preguiçosa (Lazy Initialization):** Se você marcar uma variável global ou de classe como `late` e atribuir uma expressão complexa a ela, essa expressão só será executada na primeira vez que a variável for lida, economizando recursos computacionais.

### Cenários onde NÃO se deve usar o `late`

> ⚠️ **Aviso Importante:** Nunca use `late` se houver qualquer chance de a variável ser lida antes de ser inicializada. Se isso acontecer, o Dart lançará uma exceção `LateInitializationError`. Se o valor pode sumir ou demorar para ser definido em fluxos assíncronos não controlados, use um tipo anulável (`?`).

---

## 4. Modificadores `final` e `const`

Se você deseja criar variáveis cujos valores não podem ser alterados após a atribuição, utilize `final` ou `const`.

### Diferenças entre `final` e `const`

| Característica | `final` | `const` |
| --- | --- | --- |
| **Definição do Valor** | Ocorre em tempo de execução (*Runtime*). | Ocorre em tempo de compilação (*Compile-time*). |
| **Imutabilidade** | A referência é imutável, mas os objetos internos podem ser modificados. | O objeto inteiro é profunda e estritamente imutável. |
| **Uso comum** | Dados vindos de APIs, respostas de banco de dados ou sensores. | Constantes matemáticas, chaves de configuração fixas, widgets estáticos. |

### Exemplos de Aplicação

```dart
// final: Definido em tempo de execução
final DateTime dataAtual = DateTime.now(); 

// const: Definido em tempo de compilação (valor fixo e imutável)
const double pi = 3.14159;
const urlBase = 'https://api.dart.dev';

```

### Por que usar `final` e `const` em vez de valores padrão?

* **Previsibilidade:** Garante que dados críticos não serão alterados acidentalmente por outras partes do sistema.
* **Performance:** Variáveis `const` são canonicalizadas pelo Dart em tempo de compilação. Isso significa que instâncias idênticas compartilham o mesmo espaço de memória, o que otimiza significativamente o uso de memória e acelera a renderização (especialmente útil na árvore de Widgets do Flutter).

---

## 5. Tipos Básicos: Números, Textos e Booleanos

### Números (`int` e `double`)

O Dart possui suporte nativo para números inteiros (`int`) e de ponto flutuante (`double`). Ambos herdam da classe `num`.

#### Documentação de Métodos e Propriedades de `int`

* `abs()`: Retorna o valor absoluto do número inteiro.
* `ceil()`: Retorna o menor inteiro não menor que o número (retorna o próprio número no caso de `int`).
* `floor()`: Retorna o maior inteiro não maior que o número.
* `isEven`: Propriedade booleana que retorna `true` se o número for par.
* `isOdd`: Propriedade booleana que retorna `true` se o número for ímpar.
* `toString()`: Converte o número inteiro para sua representação em texto (`String`).
* `clamp(num lowerLimit, num upperLimit)`: Restringe o número para ficar dentro do intervalo especificado.
* `int.parse(String source)`: Método estático que analisa uma string e retorna o inteiro correspondente. Lança erro se a conversão falhar.
* `int.tryParse(String source)`: Método estático semelhante ao parse, mas retorna `null` em vez de lançar um erro se a string não for um número válido.

```dart
int idade = -25;
print(idade.abs()); // Saída: 25
print(idade.isNegative); // Saída: true

int? parsed = int.tryParse('123a'); // Saída: null

```

---

### Textos (`String`)

Uma `String` em Dart representa uma sequência de caracteres UTF-16.

#### Principais Métodos de `String`

* `contains(Pattern other)`: Verifica se o texto contém a sequência informada.
* `toLowerCase()` / `toUpperCase()`: Transforma o texto em minúsculas ou maiúsculas.
* `trim()`: Remove os espaços em branco no início e no fim do texto.
* `replaceAll(Pattern from, String replace)`: Substitui todas as ocorrências de um padrão por outro termo.
* `split(Pattern pattern)`: Divide a string em uma lista de substrings com base em um delimitador fornecido.

#### Exemplo Prático do uso de `split()`

O método `split()` é ideal para processar dados tabulares, tags ou strings separadas por delimitadores específicos.

```dart
void main() {
  String linguagensPermitidas = 'Dart,Flutter,JavaScript,Python';
  
  // Divide a String a cada vírgula encontrada
  List<String> listaLinguagens = linguagensPermitidas.split(',');
  
  print(listaLinguagens); 
  // Saída: [Dart, Flutter, JavaScript, Python]
  
  print(listaLinguagens[0]); 
  // Saída: Dart
}

```

---

### Booleanos (`bool`)

O Dart possui o tipo `bool` para representar valores lógicos literais: `true` e `false`. Diferente de linguagens como JavaScript, o Dart não possui o conceito de valores *"truthy"* ou *"falsy"*. Somente a expressão booleana `true` avalia como verdadeira.

```dart
bool estaAtivo = true;

if (estaAtivo) {
  print('O sistema está operando.');
}

```


IA UTILIZADA : GEMINI 3.5 THINKING


Observações: 