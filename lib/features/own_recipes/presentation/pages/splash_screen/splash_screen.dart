import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/bottom');
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          width: 300,
          'assets/splash.webp',
          fit: BoxFit.cover,
        ).animate(delay: const Duration(milliseconds: 1000)).scale(),
      ),
    );
  }
}
