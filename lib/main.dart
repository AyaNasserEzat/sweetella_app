import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/login_screen.dart';
import 'package:sweetella/feature/home/presentation/screens/bottom_nav_bar.dart';

void main() {
  runApp(const DonutApp());
}

class DonutApp extends StatelessWidget {
  const DonutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
      title: 'Sweetella Donuts',
      home: const LoginScreen(),
    );
  }
}
