
import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_card.dart';

class DountsGridView extends StatelessWidget {
  const DountsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 14,
        childAspectRatio: .72 /1,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final donuts = [
          {
            "title": "Chocolate Glaze",
            "price": "5.49",
            "image": "assets/images/donuts_image.png",
            "backgroundColor": Color(0xfff8e6e1),
          },
          {
            "title": "Chocolate Glaze",
            "price": "5.49",
            "salePrice": "4.49",
            "image": "assets/images/donuts_image.png",
            "backgroundColor": Color(0xfffef6c9),
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
    );
  }
}
