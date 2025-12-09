import 'package:flutter/cupertino.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class RowOfPriceAndSalePrice extends StatelessWidget {
  const RowOfPriceAndSalePrice({
    super.key,
    required this.salePrice,
    required this.price,
  });

  final String? salePrice;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              spacing: 3,
              children: [
                if (salePrice != null)
                  Text("$salePrice\$", style: AppTextStyles.priceTextGreen),
                Text(
                  salePrice != null ? " $price\$" : "$price\$",
                  style: salePrice != null
                      ? AppTextStyles.text18GreyLineThrough
                      : AppTextStyles.text16BoldBlack,
                ),
              ],
            ),
          ),
        ),
        const Icon(
          CupertinoIcons.cart_badge_plus,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          size: 22,
        ),
      ],
    );
  }
}
