void main(List<String> args) {
  final estados = {
    'SC': ['Gaspar', 'Blumenau', 'Florianopolis'],
    'PR': ['Curitiba', 'Cascavel', 'Foz do Iguacu'],
    'SP': ['Sao Paulo', 'Guarulhos', 'Campinas'],
    'MG': ['Belo Horizonte', 'Juiz de Fora', 'Berlinda'],
  };

  print("Estados : Cidades");

  print('Siglas dos Estados: ${estados.keys.join(' ; ')}');

  final cidadesSc = estados['SC']!;
  cidadesSc.sort();

  print('Cidades de SC: ${cidadesSc.join(' ; ')}');

  final cidadesComSigla = [];

  for (var sigla in estados.keys) {
    for (var cidade in estados[sigla]!) {
      cidadesComSigla.add("$cidade - $sigla");
    }
  }

  cidadesComSigla.sort();
  print("Cidades em ordem alfabética: ");
  for (var item in cidadesComSigla) {
    print(item);
  }
}
