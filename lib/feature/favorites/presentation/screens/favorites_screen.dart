import 'package:flutter/material.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/product_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteDonuts = [
    {
      "title": "Chocolate Glaze",
      "price": "5.49",
      "image": "assets/images/donuts_image.png",
      "backgroundColor": Color(0xfff8e6e1),
    },
    {
      "title": "Strawberry Frost",
      "price": "5.49",
      "salePrice": "4.49",
      "image": "assets/images/donuts_image.png",
      "backgroundColor": Color(0xfffef6c9),
    },
    {
      "title": "Blueberry Delight",
      "price": "5.49",
      "salePrice": "4.49",
      "image": "assets/images/donuts_image.png",
      "backgroundColor": Color(0xffcbedf0),
    },
    {
      "title": "Vanilla Dream",
      "price": "5.49",
      "image": "assets/images/donuts_image.png",
      "backgroundColor": Color(0xfff5f1f3),
    },
    {
      "title": "Chocolate Glaze",
      "price": "5.49",
      "image": "assets/images/donuts_image.png",
      "backgroundColor": Color(0xfff8e6e1),
    },
    {
      "title": "Strawberry Frost",
      "price": "5.49",
      "salePrice": "4.49",
      "image": "assets/images/donuts_image.png",
      "backgroundColor": Color(0xfffef6c9),
    },
  ];

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 35, bottom: 80),
        child: Column(
          children: [
            AppBarTitle(title: 'My Favorites'),
            GridView.builder(
              padding: EdgeInsets.all(horizontalPadding),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
                childAspectRatio: 0.72,
              ),
              itemCount: favoriteDonuts.length,
              itemBuilder: (context, index) {
                final donut = favoriteDonuts[index];
                return Container();
                //  DonutCard(
                //   title: donut["title"] as String,
                //   price: donut["price"] as String,
                //   salePrice: donut["salePrice"] as String?,
                //   image: donut["image"] as String,
                //   backgroundColor: donut["backgroundColor"] as Color,
                //   showSaleBadge: donut["salePrice"] != null,
                //   onAddToCart: () {
                //     // Add to cart functionality
                //   },
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
