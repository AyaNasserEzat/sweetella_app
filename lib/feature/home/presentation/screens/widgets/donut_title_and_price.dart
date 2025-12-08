import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class DonutTitleAndPrice extends StatelessWidget {
  const DonutTitleAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Delicious Donut',
          style: AppTextStyles.text24BoldPink,
        ),
        SizedBox(height: 8),
        Text(
          r'Price: $3.99',
          style: AppTextStyles.text18Grey,
        ),
      ],
    );
  }
}
