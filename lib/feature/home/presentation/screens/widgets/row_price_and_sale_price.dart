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
      spacing: 4,
      children: [
        if (salePrice != null)
          Text(
            "$salePrice"
            r"$",
            style: AppTextStyles.priceTextGreen,
          ),
        Text(
          " $price"
          r"$",
          style: salePrice != null
              ? AppTextStyles.text18GreyLineThrough
              : AppTextStyles.text16BoldBlack,
        ),
        Spacer(),
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
