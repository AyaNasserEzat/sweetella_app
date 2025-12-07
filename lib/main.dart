import 'package:flutter/material.dart';
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
      title: 'Sweetella Donuts',
      theme: ThemeData(primarySwatch: Colors.pink, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}
