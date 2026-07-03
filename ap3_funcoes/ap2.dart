import 'dart:math';

void main(List<String> args) {
  final valorFuncaoAB = funcaoA(funcaoB);
  final valorFuncaoAC = funcaoA(funcaoC);
  print("Resultado função A com parametro B: $valorFuncaoAB");
  print("Resultado função A com parametro C: $valorFuncaoAC");
 
}

int funcaoA(int Function(int) funcao) {
  final random = Random();
  final valor1 = random.nextInt(100);
  final valor2 = random.nextInt(100);

  return funcao(valor1) + funcao(valor2);
}

int funcaoB(int valor) {
  return valor + 10;
}

int funcaoC(int valor) {
  return valor * 2;
}
