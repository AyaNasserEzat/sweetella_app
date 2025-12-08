import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class SaleContainer extends StatelessWidget {
  const SaleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text("Sale", style: AppTextStyles.text12SmiBoldwhite),
      ),
    );
  }
}
