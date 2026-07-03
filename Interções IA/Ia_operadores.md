# Documentação Oficial (Alternativa) de Operadores em Dart

Bem-vindo ao guia definitivo de operadores em Dart. Se você quer transformar linhas de código em pura magia funcional, entender como os operadores funcionam é o seu primeiro grande passo. Dart possui uma sintaxe limpa, mas esconde superpoderes na forma como manipula suas expressões.

---

## 1. Trabalhando com Operadores: O Básico

Em Dart, os operadores nada mais são do que métodos disfarçados com uma sintaxe amigável. Quando você escreve `a + b`, por trás dos panos você está chamando o método `+` no objeto `a` (algo como `a.+(b)`).

### Precedência de Operadores

A tabela abaixo mostra a ordem de prioridade dos operadores em Dart, do mais alto (executado primeiro) ao mais baixo (executado por último):

| Categoria | Operadores |
| --- | --- |
| Pós-fixo / Unário | `expr++`, `expr--`, `!`, `-expr` |
| Multiplicativo | `*`, `/`, `~/`, `%` |
| Aditivo | `+`, `-` |
| Relacional e Tipo | `>=`, `>`, `<=`, `<`, `as`, `is`, `is!` |
| Igualdade | `==`, `!=` |
| Lógico AND | `&&` |
| Lógico OR | ` |
| Condicional | `??`, `? :` |
| Cascata | `..`, `?..` |
| Atribuição | `=`, `+=`, `-=`, `??=`, etc. |

---

## 2. Operadores Aritméticos

Dart suporta os operadores aritméticos padrão para realizar cálculos matemáticos.

| Operador | Significado |
| --- | --- |
| `+` | Adição |
| `-` | Subtração |
| `*` | Multiplicação |
| `/` | Divisão (sempre retorna um `double`) |
| `~/` | Divisão Inteira (retorna um `int`) |
| `%` | Resto da divisão (Módulo) |

### 💡 Destaque: Qual a diferença entre `/` e `~/`?

* O operador `/` realiza uma divisão convencional. Mesmo que o resultado seja exato, ele sempre retornará um número de ponto flutuante (`double`).
* O operador `~/` divide os números e descarta a parte fracionária, retornando estritamente um número inteiro (`int`).

```dart
void main() {
  double resultadoDiv = 5 / 2;    // Retorna 2.5
  int resultadoDivInteira = 5 ~/ 2; // Retorna 2
  
  print(resultadoDiv);        // 2.5
  print(resultadoDivInteira); // 2
}

```

---

## 3. Operadores Relacionais (Igualdade e Comparação)

Usados para testar a relação entre dois valores. O resultado de uma expressão relacional é sempre um `bool`.

| Operador | Significado |
| --- | --- |
| `==` | Igual a |
| `!=` | Diferente de |
| `>` | Maior que |
| `<` | Menor que |
| `>=` | Maior ou igual a |
| `<=` | Menor ou igual a |

### 💡 Destaque: O que acontece se eu comparar valores de tipos diferentes?

* **Com `==` ou `!=`:** Dart permite a comparação. Se você comparar uma `String` com um `int` (ex: `'5' == 5`), o resultado será simplesmente `false`, pois são objetos de tipos diferentes. Não haverá erro em tempo de execução.
* **Com `<`, `>`, `<=`, `>=`:** Dart **não** permite compilar o código se os tipos não forem comparáveis (como tentar ver se uma `String` é maior que um `int`). Isso acontece porque esses operadores dependem de implementações específicas (como a classe `num`).

```dart
void main() {
  // Comparação de tipos diferentes com ==
  print('5' == 5); // false (Sem erro, apenas falso)

  // O código abaixo causaria um erro de compilação:
  // print('5' > 5); 
}

```

---

## 4. Operadores de Teste e Tipo

Excelentes para garantir a segurança de tipos do seu código antes de realizar operações específicas.

| Operador | Significado |
| --- | --- |
| `is` | Retorna `true` se o objeto tiver o tipo especificado |
| `is!` | Retorna `true` se o objeto **não** tiver o tipo especificado |
| `as` | Força a conversão (typecast) de um objeto para um tipo |

### Como verifico se uma variável é de um determinado tipo?

Basta utilizar o operador `is`. O Dart é inteligente: se você verificar o tipo dentro de um bloco `if`, ele fará o **Smart Cast** (conversão automática) para aquele tipo dentro do escopo do bloco.

```dart
void main() {
  Object nome = "Dart";

  if (nome is String) {
    // Aqui dentro, 'nome' já é tratado como String automaticamente
    print(nome.length); 
  }
}

```

### Qual a função do operador `?` em testes de tipo?

Em Dart, o `?` define a **nullability** (capacidade de ser nulo) de um tipo. Ele interage com o operador `as` para evitar quebras no código ao fazer conversões de tipos que podem ser nulos.

```dart
void main() {
  Object? valor Nulo = null;
  
  // Forçando o cast para um tipo que aceita nulo
  String? texto = valorNulo as String?; 
  print(texto); // null (sem estourar erro)
}

```

---

## 5. Operadores de Atribuição

O operador básico é o `=`. No entanto, Dart oferece **operadores de atribuição compostos**, que combinam uma operação aritmética ou lógica com uma atribuição.

### Operadores Compostos

Operadores como `+=`, `-=`, `*=`, `/=`, e `??=` servem como atalhos sintáticos.

* `a += b` é o mesmo que `a = a + b`
* `a ??=` b significa: "Atribua `b` a `a` **apenas se** `a` for nulo".

```dart
void main() {
  double numero = 10;
  numero += 5; // numero = numero + 5 -> 15.0
  numero /= 3; // numero = numero / 3 -> 5.0

  String? nome;
  nome ??= "Visitante"; // Como nome era null, agora recebe "Visitante"
  nome ??= "Novo Nome"; // Não faz nada, pois nome já não é null
  
  print(nome); // "Visitante"
}

```

---

## 6. Operadores Lógicos

Usados para inverter ou combinar expressões booleanas.

| Operador | Significado |
| --- | --- |
| `!` | NOT (Inverte o valor booleano) |
| `&&` | AND (Retorna verdadeiro se ambas as condições forem verdadeiras) |
| `||` | OR (Retorna verdadeiro se pelo menos uma condição for verdadeira) |

### Como usar `&&` e `||` para combinar condições?

O segredo está em entender a avaliação de curto-circuito (*short-circuit evaluation*).

* No `&&`, se a primeira condição for falsa, Dart nem olha a segunda.
* No `||`, se a primeira condição for verdadeira, Dart ignora a segunda.

### ⚠️ Como evitar problemas com operadores lógicos?

1. **Use parênteses explicitamente:** A precedência do `&&` é maior que a do `||`. Sem parênteses, você pode gerar bugs lógicos difíceis de rastrear.
2. **Cuidado com efeitos colaterais:** Não coloque funções que alteram estados na segunda parte de uma verificação de curto-circuito, pois elas podem nunca ser executadas.

```dart
void main() {
  bool temIdade = true;
  bool temAutorizacao = false;
  bool temIngresso = true;

  // CORRETO: Parênteses deixam claro o que deve ser avaliado junto
  bool podeEntrar = (temIdade || temAutorizacao) && temIngresso;
  print(podeEntrar); // true
}

```

---

## 7. Expressões Condicionais

Dart oferece duas formas compactas de substituir estruturas `if-else` simples, transformando blocos de código em expressões que retornam valores.

1. **Ternário:** `condição ? expressão1 : expressão2`
2. **Null-coalescing:** `expressão1 ?? expressão2` (Se expressão1 não for nula, retorna ela; senão, retorna expressão2).

### Qual a diferença entre usar `if-else` e expressões condicionais?

* `if-else` é uma **instrução** (statement). Ela dita o fluxo de execução, mas não gera um valor diretamente.
* Expressões condicionais geram um **valor** (expression). Elas podem ser atribuídas diretamente a uma variável ou passadas como argumento.

```dart
void main() {
  int nota = 8;
  
  // Usando Expressão Condicional (Ternário)
  String status = nota >= 7 ? "Aprovado" : "Reprovado";
  print(status);
}

```

### ❌ Exemplos de mau uso do ternário

O operador ternário deve ser usado para legibilidade. Se ele complicar o código, use `if-else`.

* **Ternários Aninhados (O pesadelo da manutenção):**
```dart
// MAU USO: Difícil de ler e entender de primeira
String resultado = pontuacao > 90 ? "Excelente" : pontuacao > 70 ? "Bom" : "Regular";

```


* **Usar ternário para executar ações em vez de retornar valores:**
```dart
// MAU USO: Não use para executar funções sem retorno
pontuacao > 50 ? salvarProgresso() : deletarProgresso();

```



---

## 8. Notação em Cascata (`..`, `?..`)

A notação em cascata permite realizar uma sequência de operações (métodos, acessos a propriedades, atribuições) no mesmo objeto, sem a necessidade de repetir o nome do objeto ou criar variáveis temporárias.

### Diferença entre cascata e chamadas separadas

> **Sem Cascata (Abordagem Tradicional):**
> Você precisa chamar o objeto linha por linha. Se um método retornar `void`, você não consegue encadear chamadas.

```dart
var construtor = StringBuilder();
construtor.write('Olá ');
construtor.write('Mundo');

```

> **Com Cascata (`..`):**
> Cada operação é realizada no objeto original, ignorando o retorno do método.

```dart
var construtor = StringBuilder()
  ..write('Olá ')
  ..write('Mundo');

```

### Em quais situações a cascata torna o código mais legível?

Ela brilha na **configuração e inicialização de objetos complexos**, onde você precisa preencher muitas propriedades de uma vez só logo após instanciar a classe.

### Como a notação em cascata pode ser usada após testes de tipo?

Se você tem um objeto genérico e descobre o tipo dele via `is`, você pode usar o operador de cast seguido da cascata para configurar o objeto de forma limpa.

```dart
class Cadastro {
  String nome = '';
  int idade = 0;
}

void modificarObjeto(dynamic objeto) {
  if (objeto is Cadastro) {
    // Faz o cast e já altera as propriedades usando cascata
    (objeto as Cadastro)
      ..nome = 'Carlos'
      ..idade = 25;
  }
}

```

*Nota: Se o objeto puder ser nulo, utilize a variação de cascata nula (`?..`).*

---

## 💡 Bônus: Parâmetros Opcionais e Requeridos em Funções Dart

Embora façam parte da assinatura de funções, o uso de chaves `{}` e colchetes `[]` funciona como operadores de definição de escopo para valores.

* **Parâmetros Nomeados Opcionais (`{Tipo? nome}`):** Passados pelo nome. São opcionais e aceitam nulo por padrão.
* **Parâmetros Nomeados Requeridos (`{required Tipo nome}`):** Passados pelo nome, mas o compilador obriga o envio do dado.
* **Parâmetros Posicionais Opcionais (`[Tipo? nome]`):** Passados pela ordem em que aparecem, envoltos por colchetes.

```dart
// { } define parâmetros nomeados. 'idade' é opcional, 'nome' é obrigatório.
void criarUsuario({required String nome, int? idade}) {
  print("Usuário: $nome, Idade: ${idade ?? 'Não informada'}");
}

// [ ] define parâmetros posicionais opcionais.
void saudar(String nome, [String? saudacao]) {
  print("${saudacao ?? 'Olá'}, $nome!");
}

void main() {
  criarUsuario(nome: "Ana"); // idade é omitida sem problemas
  saudar("Pedro");          // Retorna: Olá, Pedro!
  saudar("Pedro", "Bem-vindo"); // Retorna: Bem-vindo, Pedro!
}

```