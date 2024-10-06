abstract class Shape {
  void draw();
}

class Home {
  void buildHome() {}
}

class Circle implements Shape {
  @override
  void draw() {
    print("Circle");
  }
}

class Squared implements Shape, Home {
  @override
  void draw() {
    // TODO: implement draw
  }

  @override
  void buildHome() {
    // TODO: implement buildHome
  }
}
