import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';

class PriceAndSalPrice extends StatelessWidget {
  const PriceAndSalPrice({
    super.key,
    required this.item,
  });

  final CartItem item;

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
                  Text("${item.salePrice}\$", style: AppTextStyles.priceTextGreen),
                Text(
                  item.salePrice != null ? " ${item.price}\$" : "${item.price}\$",
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
    // Row(
    //   spacing: 10,
    //   children: [
    //     if (item.salePrice != null)
    //       Text(
    //         "${item.salePrice}"
    //         r"$",
    //         style: const TextStyle(
    //           color: Colors.green,
    //           fontSize: 14,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     Text(
    //       "${item.price}"
    //       r"$",
    //       style: TextStyle(
    //         color: item.salePrice != null
    //             ? Colors.grey
    //             : Colors.black,
    //         fontSize: 14,
    //         fontFamily: 'Nunito',
    //         fontVariations: [FontVariation('wght', 800)],
    //         decoration: item.salePrice != null
    //             ? TextDecoration.lineThrough
    //             : null,
    //       ),
    //     ),
    //   ],
    // );
  
  }
}
