import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isWeb = kIsWeb && screenWidth > 900;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Image.asset(
          "assets/images/splash.jpg",
          width: screenWidth,
          height: screenHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}