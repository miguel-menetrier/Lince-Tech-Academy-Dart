void main(List<String> args) {

  buscarDados();
}

Future<void> buscarDados() async {
  print("Buscando dados do usuário...");
  await Future.delayed(Duration(seconds: 5));

  print("Encontrado!");

  print("Formatando dados ...");
  await Future.delayed(Duration(seconds: 3));

 
  print("""---Usuário--- 
  id: 122345 
  email: user@email.com""");
  
}
