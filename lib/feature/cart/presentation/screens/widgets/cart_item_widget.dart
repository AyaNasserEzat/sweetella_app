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
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset(item.image, width: 60, height: 60, fit: BoxFit.contain),
          const SizedBox(width: 12),
          //  NAME & PRICE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontVariations: [FontVariation('wght', 800)],
                ),
              ),

              Text(
                "Size: ${item.size}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Nunito',
                  fontVariations: [FontVariation('wght', 600)],
                ),
              ),

              PriceAndSalPrice(item: item),
            ],
          ),
          const Spacer(),
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
              SizedBox(height: 15),
              RowPlusOrMinus(),
            ],
          ),
        ],
      ),
    );
  }
}
