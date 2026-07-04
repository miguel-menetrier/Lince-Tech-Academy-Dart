void main(List<String> args) {
  try {
    final String nomeArquivo = "";

    final arquivoTexto = ArquivoTexto(nomeArquivo);

    arquivoTexto.abrir();
  } catch (e) {
    print(e);
    
  } finally {
    print("FIM");
  }
}

abstract class Arquivo {
  void abrir();
}

class ArquivoTexto implements Arquivo {
  ArquivoTexto(this.nome);
  String nome;
  @override
  void abrir() {
    try {
      throw Exception("Erro ao abrir o arquivo $nome");
    } catch (e) {
      print("Relançar execao");
      rethrow; 
    }
  }
}
