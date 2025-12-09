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
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = constraints.maxHeight;
        final imageHeight = cardWidth * 0.4; // Scale image height with card width
        final paddingValue = cardWidth * 0.04; // 4% of card width for padding
        final spacing = cardHeight * 0.03; // 3% of card height for spacing

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
                  padding: EdgeInsets.all(paddingValue),
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
                      Center(child: Image.asset(image, height: imageHeight)),
                      SizedBox(height: spacing),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(title, style: AppTextStyles.text16BoldBlack),
                      ),
                      SizedBox(height: spacing * 0.5),
                      RowOfPriceAndSalePrice(salePrice: salePrice, price: price),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
