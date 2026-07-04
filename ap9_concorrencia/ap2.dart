Future<void> main() async {
  List<String> urls = [
    'https://example.com/imagem1.jpg',
    'https://example.com/imagem2.jpg',
    'https://example.com/imagem3.jpg',
  ];

  await baixarImagens(urls);
}

Future<void> baixarImagens(List<String> url) async {
  for (var imagem in url) {
    await Future.delayed(Duration(seconds: 2));
    print("Imagem $imagem baixada com sucesso!");
  }
}
