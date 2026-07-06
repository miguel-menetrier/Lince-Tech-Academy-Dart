void main() {
  final musicas = <Musica>[
    Musica(
      'Bohemian Rhapsody',
      'Queen',
      'A Night at the Opera',
      const Duration(minutes: 6),
    ),
    Musica(
      'Imagine',
      'John Lennon',
      'Imagine',
      const Duration(minutes: 3, seconds: 15),
    ),
    Musica(
      'Hey Jude',
      'The Beatles',
      'Hey Jude',
      const Duration(minutes: 7, seconds: 11),
    ),
    Musica(
      'Come Together',
      'The Beatles',
      'Abbey Road',
      const Duration(minutes: 4, seconds: 20),
    ),
  ];

  final biblioteca = Biblioteca(musicas);

  print('=== Biblioteca ===');
  biblioteca.imprimirMusicas();

  print('\nQuantidade de músicas: ${biblioteca.contarMusicas()}');
  final duracao = biblioteca.calcularDuracaoTotal();

  final horas = duracao.inHours;
  final minutos = duracao.inMinutes.remainder(60);
  final segundos = duracao.inSeconds.remainder(60);

  print('Tempo total: ${horas}h ${minutos}min ${segundos}s');

  print('\n=== Busca por título ===');
  print(biblioteca.buscarPorTitulo('Imagine'));

  print('\n=== Busca por artista ===');
  print(biblioteca.buscarPorArtista('The Beatles'));

  print('\n=== Busca por álbum ===');
  print(biblioteca.buscarPorAlbum('Abbey Road'));
}

class Musica {
  final String titulo;
  final String artista;
  final String album;
  final Duration duracao;

  Musica(this.titulo, this.artista, this.album, this.duracao);

  @override
  String toString() {
    final minutos = duracao.inMinutes.remainder(60).toString().padLeft(2, '0');
    final segundos = duracao.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$titulo - $artista - $album - $minutos:$segundos';
  }
}

class Biblioteca {
  late List<Musica> listaDeMusicas;

  Biblioteca(this.listaDeMusicas);
  void imprimirMusicas() {
    listaDeMusicas.forEach(print);
  }

  int contarMusicas() {
    return listaDeMusicas.length;
  }

  Duration calcularDuracaoTotal() {
    Duration duracaoTotal = Duration.zero;

    for (final musica in listaDeMusicas) {
      duracaoTotal += musica.duracao;
    }

    return duracaoTotal;
  }

  List<Musica> buscarPorTitulo(String titulo) {
    return listaDeMusicas.where((musica) => musica.titulo == titulo).toList();
  }

  List<Musica> buscarPorArtista(String artista) {
    return listaDeMusicas.where((musica) => musica.artista == artista).toList();
  }

  List<Musica> buscarPorAlbum(String album) {
    return listaDeMusicas.where((musica) => musica.album == album).toList();
  }
}
