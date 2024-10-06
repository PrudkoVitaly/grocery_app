import 'package:flutter/material.dart';

class Transport {
  final double speed;

  Transport(this.speed);

  void move() {
    print("Transport is moving at $speed km/h");
  }
}

class Car extends Transport {
  Car(double speed) : super(speed);

  void honk() {
    print("Car is honking");
  }
}

class Bike extends Transport {
  Bike(double speed) : super(speed);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
