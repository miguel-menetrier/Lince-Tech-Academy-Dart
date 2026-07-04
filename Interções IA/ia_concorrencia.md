## Guia Completo de Concorrência em Dart: Dominando a Programação Assíncrona com `Future`

Programar aplicativos modernos exige que saibamos lidar com tarefas que levam tempo — como buscar dados de uma API, ler um arquivo ou acessar um banco de dados local. Se fizermos isso da maneira errada, a interface do usuário (UI) trava, gerando aquela experiência horrível de "aplicativo congelado".

Em Dart, lidamos com isso usando o modelo de concorrência assíncrona baseado em um **Event Loop**. Vamos entender como isso funciona na prática!

---

## 1. O que significam os termos "Síncrono" e "Assíncrono"?

Antes de codificar, precisamos alinhar os conceitos básicos. A diferença fundamental está em como o fluxo de execução espera (ou não) pelas tarefas:

* **Síncrono (Synchronous):** O código é executado linha por linha, na ordem em que foi escrito. Se a Linha 2 for uma tarefa pesada (como baixar uma imagem de 50MB), a Linha 3 só será executada *depois* que o download terminar. O programa inteiro fica "pausado" esperando.
* **Assíncrono (Asynchronous):** Permite que você inicie uma tarefa demorada e, em vez de travar o programa esperando por ela, o Dart continua executando as próximas linhas de código. Quando a tarefa demorada finalmente termina, o Dart te avisa e entrega o resultado.

---

## 2. O que é um `Future` e quando utilizá-lo?

Um **`Future`** é um objeto que representa uma promessa de que um valor (ou um erro) estará disponível em algum momento no futuro. É como fazer um pedido em um balcão de fast-food: você recebe um bipe (o `Future`). Você pode se sentar e mexer no celular (outras tarefas). Quando o bipe vibrar, significa que seu hambúrguer (o resultado) está pronto.

### Em quais situações devo usar Futures?

Você deve usar `Future` sempre que a operação depender de fatores externos ao processador principal do dispositivo, tais como:

* Fazer requisições HTTP (chamar APIs Rest).
* Ler ou gravar dados no armazenamento local (SharedPreferences, bancos de dados como SQLite/Isar).
* Ler ou escrever em arquivos físicos do sistema.
* Aguardar um timer ou delay intencional.

---

## 3. Criando e Simulando Futures (Atrasos e Erros)

Para testarmos nossos códigos sem precisar de uma API real, o Dart nos fornece construtores excelentes para simular cenários do mundo real.

### Como simular uma demora com `Future.delayed`

Podemos criar uma função que simula um carregamento de banco de dados que demora 2 segundos:

```dart
Future<String> buscarDadosDoUsuario() {
  // Retorna um Future que será concluído após 2 segundos
  return Future.delayed(Duration(seconds: 2), () {
    return 'Usuário: João Dev';
  });
}

```

### Como simular um erro com `Future.error`

Às vezes precisamos testar como nosso aplicativo se comporta quando a internet cai ou o servidor falha. Usamos o `Future.error`:

```dart
Future<String> buscarDadosComFalha() {
  // Retorna um Future que falha imediatamente (ou após um tempo)
  return Future.delayed(Duration(seconds: 1), () {
    return Future.error(Exception('Falha na conexão com o servidor!'));
  });
}

```

---

## 4. Como esperar por um Future e obter o resultado?

Existem duas formas principais de extrair o valor de dentro de um `Future` quando ele for concluído: usando a sintaxe moderna `async`/`await` ou usando a sintaxe clássica com `.then()`.

### Abordagem A: Usando `async` e `await` (Recomendado)

Esta é a forma mais limpa e legível. Ela faz com que o código assíncrono se pareça visualmente com um código síncrono.

* A palavra `async` avisa ao Dart que a função possui operações assíncronas.
* A palavra `await` pausa a execução daquela função específica até que o `Future` resolva.

```dart
Future<void> exibirPerfil() async {
  print('Solicitando dados...');
  
  // O await "abre" o Future e joga a String diretamente na variável
  String usuario = await buscarDadosDoUsuario(); 
  
  print('Dados recebidos com sucesso: $usuario');
}

```

### Abordagem B: Usando `.then()` (Abordagem Funcional)

Se você não quiser ou não puder transformar sua função em `async`, pode registrar um *callback* usando `.then()`:

```dart
void exibirPerfilComThen() {
  print('Solicitando dados...');

  buscarDadosDoUsuario().then((usuario) {
    print('Dados recebidos com sucesso via .then: $usuario');
  });

  print('Esta linha roda ANTES do .then terminar!');
}

```

> ⚠️ **Cuidado:** No exemplo com `.then()`, a última linha ("Esta linha roda ANTES...") será impressa imediatamente, antes mesmo do usuário aparecer na tela, pois o fluxo principal não parou para esperar.

---

## 5. Tratamento de Erros: O que acontece se um Future falhar?

Se um `Future` falhar e você não capturar esse erro, seu programa pode lançar uma exceção não tratada (*unhandled exception*), o que no Flutter pode travar a tela ou fechar o app. Veja como se proteger:

### Tratamento com `async` / `await` (`try-catch`)

Usamos a estrutura padrão do Dart para capturar erros:

```dart
Future<void> carregarDadosSeguros() async {
  try {
    print('Iniciando busca...');
    String dados = await buscarDadosComFalha();
    print('Isso não será executado se houver erro: $dados');
  } catch (error) {
    print('Capturado um erro no catch: $error');
  } finally {
    print('Operação finalizada (sucesso ou falha).');
  }
}

```

### Tratamento com `.then()` (`.catchError`)

Se optar por usar `.then()`, você deve encadear o método `.catchError()` logo em seguida:

```dart
void carregarDadosSegurosComThen() {
  buscarDadosComFalha()
    .then((dados) => print('Sucesso: $dados'))
    .catchError((error) => print('Erro capturado no catchError: $error'));
}

```

---

## 6. Executando várias tarefas assíncronas em paralelo / simultâneo

Imagine que você precisa buscar o perfil do usuário, a lista de produtos e os anúncios da tela inicial ao mesmo tempo. Se você usar `await` em cada um, eles vão rodar em fila (um após o outro), demorando muito mais.

Podemos disparar todos juntos usando **`Future.wait()`**. Ele recebe uma lista de Futures, executa-os de forma concorrente e retorna uma lista com os resultados de todos quando todos terminarem.

```dart
Future<void> carregarTelaInicial() async {
  print('Carregando múltiplos dados em paralelo...');
  
  var stopwatch = Stopwatch()..start();

  // Simulação de 3 tarefas independentes
  Future<String> f1 = Future.delayed(Duration(seconds: 2), () => 'Usuário');
  Future<List<String>> f2 = Future.delayed(Duration(seconds: 3), () => ['Prod 1', 'Prod 2']);
  Future<int> f3 = Future.delayed(Duration(seconds: 1), () => 5); // 5 notificações

  // Aguarda todas terminarem concorrentemente
  List<dynamic> resultados = await Future.wait([f1, f2, f3]);

  print('Todos os dados chegaram em: ${stopwatch.elapsed.inSeconds} segundos!');
  print('Resultado 1: ${resultados[0]}'); // 'Usuário'
  print('Resultado 2: ${resultados[1]}'); // ['Prod 1', 'Prod 2']
  print('Resultado 3: ${resultados[2]}'); // 5
}

```

> 💡 **Nota de performance:** No exemplo acima, em vez de demorar 6 segundos ($2 + 3 + 1$), o código demora apenas **3 segundos** (o tempo da maior tarefa), pois todas rodaram juntas.

---

## 7. Quais cuidados devo tomar ao NÃO usar `await`?

O esquecimento ou omissão intencional do `await` pode gerar bugs difíceis de rastrear.

```dart
Future<void> salvarNoBanco() async {
  await Future.delayed(Duration(seconds: 2));
  print('Dados salvos no banco!');
}

void rotinaDeClique() {
  print('Iniciando processo...');
  salvarNoBanco(); // <--- ATENÇÃO: Sem await aqui!
  print('Processo finalizado com sucesso!');
}

```

Ao executar `rotinaDeClique`, a saída no console será:

1. `Iniciando processo...`
2. `Processo finalizado com sucesso!`
3. *(2 segundos depois)* `Dados salvos no banco!`

### Perigos de esquecer o `await`:

* **Exceções Fantasmas:** Se `salvarNoBanco()` falhar e não houver `await` (ou `.catchError`) na função que a chamou, o erro acontecerá "em segundo plano" e você poderá perder o controle de onde capturar essa falha.
* **Inconsistência de Estados:** Se a próxima linha de código depender do que foi salvo no banco de dados, ela tentará ler dados que ainda não existem, causando falhas graves de lógica no app.

---

## 8. Código Completo para Testes

Aqui está um script Dart unificado que você pode copiar e colar no [DartPad](https://dartpad.dev) para ver tudo funcionando em tempo real:

```dart
void main() async {
  print('=== INÍCIO DO PROGRAMA ===\n');

  // 1. Execução básica com delay e await
  print('--- Teste 1: Fluxo Assíncrono Sucesso ---');
  await exemploSucesso();
  print('---------------------------------------\n');

  // 2. Tratamento de Erros
  print('--- Teste 2: Tratamento de Erros ---');
  await exemploErro();
  print('------------------------------------\n');

  // 3. Execução paralela
  print('--- Teste 3: Execução Concorrente ---');
  await carregarMapeamentoParalelo();
  print('--------------------------------------\n');

  print('=== FIM DO PROGRAMA ===');
}

Future<void> exemploSucesso() async {
  print('Buscando clima atual...');
  String clima = await Future.delayed(Duration(seconds: 1), () => 'Ensolarado, 25°C');
  print('O clima está: $clima');
}

Future<void> exemploErro() async {
  try {
    print('Tentando autenticar usuário...');
    await Future.delayed(Duration(seconds: 1), () {
      throw Exception('Senha incorreta!');
    });
  } catch (e) {
    print('Erro capturado: $e');
  }
}

Future<void> carregarMapeamentoParalelo() async {
  var tarefas = await Future.wait([
    Future.delayed(Duration(milliseconds: 500), () => 'Configurações OK'),
    Future.delayed(Duration(milliseconds: 300), () => 'Log de Acessos OK'),
  ]);
  print('Status do Sistema: $tarefas');
}

```