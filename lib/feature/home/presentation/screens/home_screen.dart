import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_chip.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_card.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/home_header.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/search_bar.dart';

class DonutsHomeScreen extends StatelessWidget {
  const DonutsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- HEADER ----------------
            HomeHeader(),
            const SizedBox(height: 25),
            // ---------------- SEARCH BAR ----------------
            SearchTextFormField(),
      
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
      
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: .75 / 1,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final donuts = [
                  {
                    "title": "Chocolate Glaze",
                    "price": "5.49",
                    "salePrice": "4.49",
                    "image": "assets/images/donuts_image.png",
                    "backgroundColor": Color(0xfff8e6e1),
                  },
                  {
                    "title": "Chocolate Glaze",
                    "price": "5.49",
                    "salePrice": "4.49",
                    "image": "assets/images/donuts_image.png",
                    "backgroundColor": Color(0xfffef6c9)  ,
                  },
                  {
                    "title": "Chocolate Glaze",
                    "price": "5.49",
                    "salePrice": "4.49",
                    "image": "assets/images/donuts_image.png",
                    "backgroundColor": Color(0xffcbedf0),
                  },
                  {
                    "title": "Chocolate Glaze",
                    "price": "5.49",
                    "salePrice": "4.49",
                    "image": "assets/images/donuts_image.png",
                    "backgroundColor": Color(0xfff5f1f3),
                  },
                ];
      
                final donut = donuts[index];
                return DonutCard(
                  title: donut["title"] as String,
                  price: donut["price"] as String,
                  salePrice: donut["salePrice"] as String?,
                  image: donut["image"] as String,
                  backgroundColor: donut["backgroundColor"] as Color,
                  showSaleBadge: true,
                  onAddToCart: () {
                    // Add to cart functionality
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
