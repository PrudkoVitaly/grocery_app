import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/presentation/screens/main_screen.dart';

import '../../data/data_source/product_data_source.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
     MainScreen(),
    ProfileScreen(),
    const Text("Favorite"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: const Color(0XFF6CC51D),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                child: Image.asset("assets/float_action_button_icon.png"),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: Center(
                  child: Text(
                    cartProducts.length.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0XFF6CC51D),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/bottom_button_home.png"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/bottom_button_profile.png"),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/favorite.png"),
            label: "Favorite",
          ),
        ],
      ),
    );
  }
}
