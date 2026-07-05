void main() {
  DateTime dataAtual = DateTime(2022, 9, 5);
  DateTime dataCalculada = adicionarDiasUteis(dataAtual, 18);

  print('Data atual: ${formatarData(dataAtual)}');
  print('Data calculada: ${formatarData(dataCalculada)}');
}

DateTime adicionarDiasUteis(DateTime data, int diasUteis) {
  int contador = 0;

  while (contador < diasUteis) {
    data = data.add(const Duration(days: 1));

    if (data.weekday >= DateTime.monday &&
        data.weekday <= DateTime.friday) {
      contador++;
    }
  }

  return data;
}

String formatarData(DateTime data) {
  String dia = data.day.toString();
  String mes = data.month.toString();
  String ano = data.year.toString();

  return '$dia/$mes/$ano';
}