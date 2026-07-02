# Documentação Técnica: Coleções em Dart

As coleções em Dart são estruturas fundamentais para agrupar e manipular dados. O ecossistema Dart oferece três tipos principais de coleções: **Lists** (Listas), **Sets** (Conjuntos) e **Maps** (Mapas).

---

## 1. Trabalhando com Listas (Lists)

Uma `List` é uma coleção ordenada de elementos onde duplicatas são permitidas. Os elementos são acessados por meio de índices baseados em zero.

### Boas Práticas no Uso de Listas

* **Tipagem Forte:** Sempre defina o tipo de dado da lista. Evite usar `List<dynamic>` a menos que seja estritamente necessário.
```dart
// Boa prática
List<String> nomes = ['Ana', 'Pedro', 'Luís'];

// Evite
List listaGenerica = ['Ana', 10, true]; 

```


* **Use literais de coleção:** Prefira usar os colchetes `[]` em vez de construtores antigos para criar listas vazias.
* **Aproveite o Spread Operator (`...`) e Collection `if`/`for`:** Eles tornam a criação de listas condicionais muito mais limpa.
```dart
bool promocaoAtiva = true;
List<String> carrinho = [
  'Camiseta',
  'Calça',
  if (promocaoAtiva) 'Brinde VIP',
];

```



### Práticas para Melhor Performance

* **Defina o tamanho se souber previamente:** Se você já sabe o tamanho exato da lista, use `List.filled(tamanho, valor padrao)` para evitar que o Dart precise realocar memória continuamente à medida que a lista cresce.
* **Evite o método `.length` dentro de loops complexos desnecessariamente:** Embora no Dart acessar o `.length` seja uma operação eficiente ($O(1)$), salvar o valor em uma variável local antes de um loop `for` tradicional pode evitar redundâncias em contextos críticos.
* **Use `ListView.builder` (no Flutter):** Se estiver renderizando listas na interface, nunca use um loop comum ou jogue todos os itens de vez na tela; o builder renderiza apenas o que está visível.

### O que NÃO fazer com Listas

> ⚠️ **Nunca modifique uma lista enquanto estiver iterando sobre ela com um loop `for-in` ou `.forEach()`.** Isso causará um erro de `ConcurrentModificationError`. Se precisar remover itens, use `.removeWhere()`.

```dart
// ERRADO: Vai quebrar em tempo de execução
for (var item in lista) {
  if (item == 'remover') lista.remove(item); 
}

// CERTO
lista.removeWhere((item) => item == 'remover');

```

### Como Iterar de Forma Eficiente

A forma mais limpa e eficiente para iterações simples é o loop `for-in`. O método `.forEach()` é bom para callbacks simples, mas o `for-in` é ligeiramente mais rápido e aceita palavras-chave como `break` e `continue`.

```dart
// Iteração eficiente e legível
for (final nome in nomes) {
  print(nome.toUpperCase());
}

```

---

## 2. Trabalhando com Conjuntos (Sets)

Um `Set` é uma coleção de elementos **únicos** e, por padrão, não ordenados.

### Cenários Favoráveis ao Uso de Sets

Use um `Set` quando a ordem dos elementos não importar, mas a **unicidade** sim. Por exemplo: IDs de usuários logados, CPFs válidos, ou categorias selecionadas em um filtro.

### Métodos Auxiliares para Listas e Sets

Tanto `List` quanto `Set` herdam de `Iterable`, o que nos dá superpoderes com métodos incríveis:

* `.where()`: Filtra os elementos com base em uma condição.
* `.any()`: Retorna `true` se ao menos um elemento atender à condição.
* `.every()`: Retorna `true` apenas se todos os elementos atenderem à condição.
* `.firstWhere()`: Encontra o primeiro elemento que bate com a busca.

### Cuidados ao Usar Sets

* **Igualdade de Objetos personalizados:** Se você colocar instâncias de classes próprias dentro de um `Set`, certifique-se de sobrescrever os operadores `==` e `hashCode`. Caso contrário, o Dart achará que dois objetos com os mesmos dados são diferentes devido ao endereço de memória.
* **Performance de busca:** A busca em um `Set` usando `.contains()` é extremamente rápida ($O(1)$), enquanto na `List` ela precisa percorrer item por item ($O(n)$).

---

## 3. Trabalhando com Mapas (Maps)

Um `Map` é uma coleção de pares **chave-valor**. As chaves devem ser únicas, mas os valores podem se repetir.

### Quando usar Lista vs. Mapas?

| Estrutura | Quando Usar | Exemplo de Caso |
| --- | --- | --- |
| **Lista (`List`)** | Quando a ordem importa e os itens são identificados por sua posição (índice). | Lista de reprodução de músicas. |
| **Mapa (`Map`)** | Quando você precisa associar uma informação a uma chave identificadora única. | Dados de um usuário associados ao seu ID (Dicionário). |

### Práticas Interessantes no Uso de Mapas

* **Use `putIfAbsent`:** Evita checagens manuais se uma chave existe antes de adicionar um valor.
```dart
Map<String, int> estoque = {'Maçã': 10};
estoque.putIfAbsent('Banana', () => 5); // Adiciona apenas se não existir

```


* **Null Safety:** Lembre-se de que acessar uma chave que não existe em um mapa retorna `null`. Use o operador `??` para garantir um valor padrão.

### Exemplo de uso do método `.map()` em Mapas

O método `.map()` em um `Map` transforma a estrutura original retornando um novo `MapEntry`. Veja como transformar os valores de um mapa:

```dart
void main() {
  Map<String, double> precosEmDolar = {
    'Notebook': 1000.0,
    'Smartphone': 500.0,
  };

  // Convertendo os preços para Real (multiplicando por 5)
  Map<String, double> precosEmReal = precosEmDolar.map((chave, valor) {
    return MapEntry(chave, valor * 5.0);
  });

  print(precosEmReal); // {Notebook: 5000.0, Smartphone: 2500.0}
}

```

---

## 4. Método em Foco: `elementAtOrNull`

Introduzido para melhorar a segurança do código, o método `elementAtOrNull` pertence à extensão de `Iterable`.

### Documentação Conceitual

> **O que ele faz:** Tenta ler o elemento presente no índice especificado. Se o índice estiver fora dos limites da coleção (ou seja, for menor que zero ou maior/igual ao tamanho da coleção), em vez de quebrar o aplicativo com um erro de *IndexOutOfBoundsException*, ele retorna de forma segura o valor `null`.

### Implementação Prática

Em vez de fazer validações manuais de tamanho de forma complexa, você pode simplesmente usá-lo assim:

```dart
void main() {
  List<String> herois = ['Batman', 'Superman', 'Wonder Woman'];

  // Índice válido
  String? heroiValido = herois.elementAtOrNull(1);
  print(heroiValido); // Saída: Superman

  // Índice inexistente (fora dos limites)
  String? heroiInexistente = herois.elementAtOrNull(10);
  print(heroiInexistente); // Saída: null

  // Uso prático com operador de valor padrão
  String heroiFinal = herois.elementAtOrNull(5) ?? 'Herói Desconhecido';
  print(heroiFinal); // Saída: Herói Desconhecido
}

```