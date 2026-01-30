import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

class DonutTitleAndPrice extends StatelessWidget {
  const DonutTitleAndPrice({super.key, required this.productModel});
final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text(
          productModel.name,
          style: AppTextStyles.text24BoldPink,
        ),
        SizedBox(height: 8),
        Text(
          'Price: ${productModel.price}\$',
          style: AppTextStyles.text18Grey,
        ),
      ],
    );
  }
}
