import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_chip.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_card.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/home_header.dart';

class DonutsHomeScreen extends StatelessWidget {
  const DonutsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- HEADER ----------------
              HomeHeader(),
              const SizedBox(height: 25),
              // ---------------- SEARCH BAR ----------------
              SearchBar(),

              const SizedBox(height: 25),

              // ---------------- CATEGORIES ----------------
              const Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryChip("All", true),
                    categoryChip("Pink Donuts", false),
                    categoryChip("Chocolate", false),
                    categoryChip("Caramel", false),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- PREMIUM SECTION ----------------
              const Text(
                "Premium Choice ✨",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    DonutCard(
                      title: "Strawberry Donut",
                      price: "4.99",
                      image: "assets/images/donuts_image.png",
                      backgroundColor: Color(0xFFFFC4DD),
                    ),
                    DonutCard(
                      title: "Chocolate Glaze",
                      price: "5.49",
                      image: "assets/images/donuts_image.png",
                      backgroundColor: Color(0xFFD7C5FF),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- POPULAR DONUTS ----------------
              const Text(
                "Popular Donuts 🍩",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
