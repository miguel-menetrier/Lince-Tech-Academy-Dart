
// ignore_for_file: unnecessary_null_comparison, dead_code

void main(List<String> args) {
   String nome = "João";
   String sobrenome = "Silva";
   int idade = 30;
   bool ativo = true;
   double peso = 81.3;
   String? nacionalidade = "Brasileiro";


  print("Nome completo: " + nome + " " + sobrenome);


  if(idade >= 18){
  print("Idade: " + idade.toString() +" (maior de idade)" );

  } else{
      print("Idade: " + idade.toString() +" (menor de idade)" );

  }
  if(ativo){
    print("Situação: Ativo");

} else{
    print("Situação: Inativo");

}

print("Peso: " + peso.toStringAsFixed(2));

if(nacionalidade != null){
  print("Nacionalidade: $nacionalidade");
  
} else{
  print("Nacionalidade não informada");
}

}
