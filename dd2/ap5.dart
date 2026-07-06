import 'dart:math'; // Necessário para o sorteio funcionar

void main() {
  // 1. Instanciando a classe com uma lista inicial vazia
  final listaMercado = ListaDeCompras([]);

  print('--- 1. ADICIONANDO ITENS À LISTA ---');
  listaMercado.adcionarItem('Arroz 5kg', 1);
  listaMercado.adcionarItem('Leite Integral', 4);
  listaMercado.adcionarItem('Café Torrado', 2);
  listaMercado.adcionarItem('Chocolate Amargo', 3);

 
  listaMercado.imprimirListaDeItems();
  listaMercado.exbirProgresso();
  print('-----------------------------------\n');

  print('--- 2. SIMULANDO AS COMPRAS NO MERCADO ---');
  // Para marcar, vamos pegar os itens de dentro da lista principal
  final item1 = listaMercado.itemsDesejados[0]; // Arroz
  final item2 = listaMercado.itemsDesejados[1]; // Leite
  final item3 = listaMercado.itemsDesejados[2]; // Café

  // Marcando 2 itens como comprados e 1 como sem estoque
  listaMercado.marcarComoComprado(item1);
  listaMercado.marcarComoComprado(item2);
  listaMercado.marcarComoSemEstoque(item3);

  print('Ações realizadas!\n');
  print('-----------------------------------\n');

  print('--- 3. EXIBINDO RESULTADOS FINAIS ---');
  print('Todos os itens e seus status atuais:');
  listaMercado.imprimirListaDeItems();

  print('\nIndicador de Progresso atualizado:');
  // Nota: Lembre-se de ajustar a lógica do seu método exbirProgresso()
  // para usar (itemsComprados.length) no primeiro número, conforme conversamos!
  listaMercado.exbirProgresso();
  print('-----------------------------------\n');

  print('--- 4. TESTANDO O SORTEIO ALEATÓRIO ---');
  // Como sobrou apenas o Chocolate como pendente, o sorteio vai selecioná-lo
  try {
    final itemSorteado = listaMercado.itemPendenteAleatorio();
    print('Item pendente escolhido aleatoriamente para comprar agora:');
    print('=> ${itemSorteado.nome} (Quantidade: ${itemSorteado.quantidade})');
  } catch (e) {
    print('Não há itens pendentes para sortear.');
  }
  print('-----------------------------------');
}

enum Status { pendente, comprado, semEstoque }

class Item {
  Item(this.nome, this.quantidade, this.status);
  String nome;
  int quantidade;

  Status status;
}

class ListaDeCompras {
  ListaDeCompras(this.itemsDesejados);
  List<Item> itemsDesejados;

  void adcionarItem(String nome, int quantidade) {
    Item item = Item(nome, quantidade, Status.pendente);

    itemsDesejados.add(item);
  }

  void imprimirListaDeItems() {
    for (var item in itemsDesejados) {
      print(
        "Nome: ${item.nome} - Quantidade: ${item.quantidade} - Status: ${item.status}",
      );
    }
  }

  List<Item> get itemsComprados =>
      itemsDesejados.where((item) => item.status == Status.comprado).toList();

  List<Item> get itemsSemEstoque =>
      itemsDesejados.where((item) => item.status == Status.semEstoque).toList();

  List<Item> get itemsPendetes =>
      itemsDesejados.where((item) => item.status == Status.pendente).toList();

  Item itemPendenteAleatorio() {
    final random = Random();
    Item itemAleatorio = itemsPendetes[random.nextInt(itemsPendetes.length)];

    return itemAleatorio;
  }

  void exbirProgresso() {
    print("Progresso: ${itemsPendetes.length}/${itemsDesejados.length}");
  }

  void marcarComoComprado(Item item) {
    item.status = Status.comprado;
  }

  void marcarComoSemEstoque(Item item) {
    item.status = Status.semEstoque;
  }
}
