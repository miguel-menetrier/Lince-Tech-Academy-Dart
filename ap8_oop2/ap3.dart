void main(List<String> args) {

  final baleia = Baleia();

  baleia.aquatico();
  baleia.mamifero();
}

abstract class Mamifero {
  void mamifero();
}

abstract class Aquatico {
  void aquatico();
}

class Baleia implements Mamifero, Aquatico {
  @override
  void aquatico() {
    print("A baleia nada");
  }

  @override
  void mamifero() {
    print("A baleia é um mamifero");
  }
}
