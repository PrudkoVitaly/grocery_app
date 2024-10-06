import 'package:flutter/material.dart';

class BankAccount {
  double _balance = 0;
  void deposit(double amount) {
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
    } else {
      print("Not enough money");
    }
  }

  double getBalance() {
    return _balance;
  }
}

class UserProfile {
  double? _weight;

  UserProfile([this._weight]);

  void setWeight(double weight) {
    if (weight > 0) {
      _weight = weight;
    } else {
      print("Invalid weight");
    }
  }

  double? getWeight() {
    return _weight;
  }
}

class BankAcountScreen extends StatefulWidget {
  const BankAcountScreen({super.key});

  @override
  State<BankAcountScreen> createState() => _BankAcountScreenState();
}

class _BankAcountScreenState extends State<BankAcountScreen> {
  TextEditingController amountController = TextEditingController();
  final BankAccount _account = BankAccount();

  final UserProfile _user = UserProfile();

  void _deposite() {
    double money = double.parse(amountController.text);
    setState(() {
      _account.deposit(money);
      amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Balance: ${_account.getBalance()}"),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      _deposite();
                    },
                    child: const Text(
                      "Deposite",
                    )),
                TextButton(
                  onPressed: () {},
                  child: const Text("Withdraw"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  TextEditingController getWeightController = TextEditingController();

  UserProfile user = UserProfile();

  void _setWeight() {
    double weight = double.parse(getWeightController.text);
    setState(() {
      user.setWeight(weight);
      getWeightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Balance: ${user.getWeight()}"),
            const SizedBox(height: 20),
            TextField(
              controller: getWeightController,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      _setWeight();
                    },
                    child: const Text(
                      "Set Weight",
                    )),
                TextButton(
                  onPressed: () {},
                  child: const Text("Withdraw"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
