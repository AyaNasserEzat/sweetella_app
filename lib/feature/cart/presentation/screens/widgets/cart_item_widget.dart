import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/price_and_sale_price.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/row_plus_or_minus.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingValue = screenWidth * 0.03; // 3% of screen width
    final imageSize = screenWidth * 0.12; // 12% of screen width for smaller screens
    final spacing = screenWidth * 0.02; // 2% for spacing
    final nameFontSize = screenWidth * 0.04; // 4% for name
    final sizeFontSize = screenWidth * 0.035; // 3.5% for size

    return Container(
      padding: EdgeInsets.all(paddingValue),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset(item.image, width: imageSize, height: imageSize, fit: BoxFit.contain),
          SizedBox(width: spacing),
          //  NAME & PRICE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: nameFontSize,
                      fontFamily: 'Nunito',
                      fontVariations: [const FontVariation('wght', 800)],
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Size: ${item.size}",
                    style: TextStyle(
                      fontSize: sizeFontSize,
                      color: Colors.grey,
                      fontFamily: 'Nunito',
                      fontVariations: [const FontVariation('wght', 600)],
                    ),
                  ),
                ),
                PriceAndSalPrice(item: item),
              ],
            ),
          ),
          SizedBox(width: spacing),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.cart_badge_minus,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: screenWidth * 0.03),
              RowPlusOrMinus(),
            ],
          ),
        ],
      ),
    );
  }
}
