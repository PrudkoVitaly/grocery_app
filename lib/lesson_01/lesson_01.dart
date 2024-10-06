import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Education level",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00394C),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  "Create a unique emotional story that describes \nbetter than words",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF605866),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 88,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFDD563),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFDD563),
                        ),
                        child: Center(
                          child: Image.asset("assets/Frame.png"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Year 7-9",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF585A66),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 88,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF8BE38B),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF8BE38B),
                        ),
                        child: Center(
                          child: Image.asset("assets/Frame2.png"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Year 10-11",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF585A66),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 88,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFB3B4F7),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFB3B4F7),
                        ),
                        child: Center(
                          child: Image.asset("assets/Frame3.png"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Year 12-13",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF585A66),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 88,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFC4D7FF),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFC4D7FF),
                        ),
                        child: Center(
                          child: Image.asset("assets/Frame4.png"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Bachelors",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF585A66),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 88,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE48FFF),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFE48FFF),
                        ),
                        child: Center(
                          child: Image.asset("assets/Frame5.png"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Masters",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF585A66),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    style: const ButtonStyle(
                        alignment: Alignment.topRight),
                    onPressed: () {},
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color(0xFF2FD1C5),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
