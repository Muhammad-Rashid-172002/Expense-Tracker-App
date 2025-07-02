import 'package:expans_traker/Screen/home/History.dart';
import 'package:expans_traker/Screen/home/Statics.dart';
import 'package:expans_traker/Screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentIndex = 0;

  final screen = [Home(), History(), Statistics()];
  // final screen = [home(), sttings(), chat()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text("History"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.pie_chart),
            title: const Text("Stats"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

// class chat extends StatelessWidget {
//   const chat({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF0F172A),
//       child: Center(
//         child: Text(
//           "Stats Screen",
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class settings extends StatelessWidget {
//   const sttings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF0F172A),
//       child: Center(
//         child: Text(
//           "History Screen",
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class home extends StatelessWidget {
//   const home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF0F172A),
//       child: Center(
//         child: Text(
//           "Home Screen",
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
