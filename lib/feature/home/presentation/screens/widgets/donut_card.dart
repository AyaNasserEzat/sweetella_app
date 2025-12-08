import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/presentation/screens/donuts_details_screen.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/row_price_and_sale_price.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/sale_container.dart';

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
            decoration: BoxDecoration(
              color: backgroundColor.withAlpha(160),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (salePrice != null) SaleContainer(),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.heart),
                      ),
                    ],
                  ),
                  Center(child: Image.asset(image, height: 80)),
                  const SizedBox(height: 8),
                  Text(title, style: AppTextStyles.text16BoldBlack),
                  const SizedBox(height: 4),
                  RowOfPriceAndSalePrice(salePrice: salePrice, price: price),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
