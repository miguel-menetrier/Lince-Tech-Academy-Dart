import 'dart:collection';
import 'dart:math';

void main(List<String> args) {
  List<Figurinha> figurinhasDoAlbum = [];

  for (var i = 0; i < 20; i++) {
    figurinhasDoAlbum.add(Figurinha());
  }

  Album album = Album();

  while (!album.isAlbumCompleto) {
    PacoteDeFigurinhas pacote = PacoteDeFigurinhas(figurinhasDoAlbum);

    for (var figurinha in pacote.pacoteDe4) {
      album.colarFigurinha(figurinha);
    }
  }

  album.imprimirAlbum();
  print(
    "Quantiade de figurinhas repetidas: ${album.figurinhasRepetidas.length}",
  );
}

class Figurinha {
  Figurinha() : codigo = codigoUnico, nome = "Figura ${codigoUnico + 100}" {
    codigoUnico++;
  }
  static int codigoUnico = 1;

  String nome;
  int codigo;
}

class PacoteDeFigurinhas {
  final List<Figurinha> pacoteDe4 = [];

  PacoteDeFigurinhas(List<Figurinha> listaDeFigurinhas) {
    final random = Random();

    for (var i = 0; i < 4; i++) {
      Figurinha figurinhaAleatoria =
          listaDeFigurinhas[(random.nextInt(listaDeFigurinhas.length))];

      pacoteDe4.add(figurinhaAleatoria);
    }
  }
}

class Album {
  final SplayTreeSet<Figurinha> album = SplayTreeSet<Figurinha>(
    (a, b) => a.codigo.compareTo(b.codigo),
  );

  bool get isAlbumCompleto => album.length == 20;

  final List<Figurinha> figurinhasRepetidas = [];

  void colarFigurinha(Figurinha figurinha) {
    final bool colouFigurinha = album.add(figurinha);

    if (colouFigurinha == false) {
      figurinhasRepetidas.add(figurinha);
    }
  }

  void imprimirAlbum() {
    print('================ FIGURINHAS COLADAS NO ÁLBUM ================');
    for (var fig in album) {
      print('[Cód: ${fig.codigo.toString().padLeft(2, '0')}] - ${fig.nome}');
    }
    print('=============================================================');
  }
}
