import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/home/presentation/screens/donuts_details_screen.dart';

class DonutCard extends StatelessWidget {
  final String title;
  final String price;
  final String? salePrice;
  final String image;
  final Color backgroundColor;
  final bool showSaleBadge;
  final VoidCallback? onAddToCart;

  const DonutCard({
    super.key,
    required this.title,
    required this.price,
    this.salePrice,
    required this.image,
    required this.backgroundColor,
    this.showSaleBadge = false,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonutsDetailsScreen()),
            );
          },
          child: Container(
            width: 170,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  backgroundColor,
                  backgroundColor.withAlpha(100),
                  backgroundColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (salePrice!=null)
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Sale",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontVariations: [FontVariation('wght', 700)],
                          ),
                        ),
                      ),
                    ),
                  Center(child: Image.asset(image, height: 80)),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    spacing: 4,
                    children: [
                      if (salePrice != null)
                        Text(
                          "${salePrice}"
                          r"$",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        " $price"
                        r"$",
                        style: TextStyle(
                          color: salePrice != null ? Colors.grey : Colors.black,
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontVariations: [FontVariation('wght', 800)],
                          decoration: salePrice != null
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      Spacer(),
                      const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: AppColors.primaryColor,
                        size: 23,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
