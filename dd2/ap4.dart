
import 'dart:math' as math;
// OBJETIVO: Utilização da refatoração no fluxo principal do programa
void main() {
  // Inicializando o comparador refatorado
  final comparador = ComparadorFormasGeometricas();

  // Instanciando formas geométricas variadas para os testes
  final circulo = Circulo('Círculo Índigo', 5.0);
  final retangulo = Retangulo('Retângulo Rubi', 4.0, 6.0);
  final quadrado = Quadrado('Quadrado Esmeralda', 4.5);
  final trianguloEq = TrianguloEquilatero('Triângulo Equilátero Topázio', 6.0);
  final trianguloRet = TrianguloRetangulo('Triângulo Retângulo Safira', 3.0, 4.0);
  final pentagono = PentagonoRegular('Pentágono Ágata', 4.0);
  final hexagono = HexagonoRegular('Hexágono Quartzo', 3.5);

  print('--- TESTE 1: Comparação de Áreas ---');
  // Comparando o Círculo com o Hexágono (Polimorfismo em ação)
  final formaMaiorArea = comparador.acharMaiorArea(circulo, hexagono);
  print(
    'Entre o ${circulo.nome} (${circulo.area.toStringAsFixed(2)}) '
    'e o ${hexagono.nome} (${hexagono.area.toStringAsFixed(2)}):',
  );
  print('-> A maior área pertence a: ${formaMaiorArea.nome}\n');

  print('--- TESTE 2: Comparação de Perímetros ---');
  // Comparando o Triângulo Retângulo com o Pentágono
  final formaMaiorPerimetro = comparador.acharMaiorPerimetro(trianguloRet, pentagono);
  print(
    'Entre o ${trianguloRet.nome} (${trianguloRet.perimetro.toStringAsFixed(2)}) '
    'e o ${pentagono.nome} (${pentagono.perimetro.toStringAsFixed(2)}):',
  );
  print('-> O maior perímetro pertence a: ${formaMaiorPerimetro.nome}\n');

  print('--- TESTE 3: Torneio entre todas as formas ---');
  // Uma lista contendo todas as formas tratadas de forma genérica (Polimorfismo)
  final List<FormaGeometrica> todasAsFormas = [
    circulo,
    retangulo,
    quadrado,
    trianguloEq,
    trianguloRet,
    pentagono,
    hexagono,
  ];

  // Algoritmo simples para descobrir quem tem a maior área de todas do sistema
  FormaGeometrica campeaArea = todasAsFormas.first;
  for (var forma in todasAsFormas) {
    campeaArea = comparador.acharMaiorArea(campeaArea, forma);
  }

  print('O grande vencedor em termos de área total é:');
  print('=> ${campeaArea.nome} com área de ${campeaArea.area.toStringAsFixed(2)}');
}

abstract class FormaGeometrica {
  String nome;
  double get area;
  double get perimetro;

  FormaGeometrica(this.nome);
}

/// Representa a forma geometrica "círculo"
class Circulo extends FormaGeometrica {
  /// Construtor padrao, recebe o [raio] do círculo.
  Circulo(String nome, this.raio) : super(nome);
  final double raio;

  /// Retorna a area desse círculo
  double get area => math.pi * math.pow(raio, 2);

  /// Retorna o perímetro desse círculo
  double get perimetro => 2 * math.pi * raio;
}

/// Representa a forma geometrica "retângulo", forma geometrica de quatro lados
/// e angulos retos (90 graus).
class Retangulo extends FormaGeometrica {
  /// Construtor padrao, recebe a [altura] e [largura] do retângulo
  Retangulo(String nome, this.altura, this.largura) : super(nome);

  final double largura;
  final double altura;

  @override
  double get area => altura * largura;

  @override
  double get perimetro => (altura * 2) + (largura * 2);
}

/// Representa a forma geometrica "quadrado", que e um formato especial de
/// retângulo, onde todos os lados possuem o mesmo tamanho.
class Quadrado extends FormaGeometrica {
  /// Construtor padrao, recebe o [lado] do quadrado
  Quadrado(String nome, this.lado) : super(nome);

  final double lado;

  @override
  double get area => lado * lado;

  @override
  double get perimetro => lado * 4;
}

class TrianguloEquilatero extends FormaGeometrica {
  TrianguloEquilatero(String nome, this.lado) : super(nome);

  final double lado;

  @override
  double get area => (math.pow(lado, 2) * math.sqrt(3)) / 4;

  @override
  double get perimetro => 3 * lado;
}

class TrianguloRetangulo extends FormaGeometrica {
  TrianguloRetangulo(String nome, this.base, this.altura) : super(nome);

  double base;

  double altura;

  @override
  // TODO: implement area
  double get area => (base * altura) / 2;

  @override
  double get perimetro =>
      base + altura + (math.sqrt(((base * base) + (altura * altura))));
}

class PentagonoRegular extends FormaGeometrica {
  PentagonoRegular(String nome, this.lado) : super(nome);

  double lado;

  @override
  // TODO: implement area
  double get area => 1.72048 * (lado * lado);

  @override
  // TODO: implement perimetro
  double get perimetro => 5 * lado;
}

class HexagonoRegular extends FormaGeometrica {
  HexagonoRegular(String nome, this.lado) : super(nome);

  double lado;

  @override
  // TODO: implement area
  double get area => (3 * (math.sqrt(3)) * (lado * lado)) / 2;

  @override
  // TODO: implement perimetro
  double get perimetro => 6 * lado;
}

/// Compara caracteristicas de formas geometricas
class ComparadorFormasGeometricas {
  FormaGeometrica acharMaiorArea(
    FormaGeometrica formaA,
    FormaGeometrica formaB,
  ) {
    if (formaA.area > formaB.area) {
      return formaA;
    } else if (formaB.area > formaA.area) {
      return formaB;
    }

    return formaA;
  }

  FormaGeometrica acharMaiorPerimetro(
    FormaGeometrica formaA,
    FormaGeometrica formaB,
  ) {
    if (formaA.perimetro > formaB.perimetro) {
      return formaA;
    } else if (formaB.perimetro > formaA.perimetro) {
      return formaB;
    }

    return formaA;
  }
}
