import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';

class PriceAndSalPrice extends StatelessWidget {
  const PriceAndSalPrice({super.key, required this.item});

  final CartItemModel item;

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
                if (item.salePrice != null)
                  Text(
                    "${item.salePrice}\$",
                    style: AppTextStyles.priceTextGreen,
                  ),
                Text(
                  item.salePrice != null
                      ? " ${item.price}\$"
                      : "${item.price}\$",
                  style: item.salePrice != null
                      ? AppTextStyles.text18GreyLineThrough
                      : AppTextStyles.text16BoldBlack,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
