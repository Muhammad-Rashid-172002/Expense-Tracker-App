import 'package:expans_traker/Screen/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/Animation - 1751452546717.json',
              width: 200,
              height: 200,
            ),

            SizedBox(height: 20),
            FadingText(
              'Welcome To Expense Tracker...',
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
