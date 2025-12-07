
import 'package:flutter/material.dart';
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
      spacing: 10,
      children: [
        if (item.salePrice != null)
          Text(
            "${item.salePrice}"
            r"$",
            style: const TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        Text(
          "${item.price}"
          r"$",
          style: TextStyle(
            color: item.salePrice != null
                ? Colors.grey
                : Colors.black,
            fontSize: 14,
            fontFamily: 'Nunito',
            fontVariations: [FontVariation('wght', 800)],
            decoration: item.salePrice != null
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
      ],
    );
  }
}
