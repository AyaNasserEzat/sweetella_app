import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class PrimaryColorContainer extends StatelessWidget {
  const PrimaryColorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(200)),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          const Text("Sweetella", style: AppTextStyles.text32BoldWhite),
          Image.asset("assets/images/donuts_image.png", width: 120),
        ],
      ),
    );
  }
}
