void main(List<String> args) {
  Lobo lobo = Lobo();

  lobo.beber();
  lobo.comer();
  lobo.uivar();
}

abstract class Animal {
  void comer() {
    print("Comendo");
  }

  void beber() {
    print("Bebendo");
  }
}

class Lobo extends Animal {
  void uivar() {
    print("O lobo está uivando");
  }
}
