import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class PrimaryColorContainer extends StatelessWidget {
  const PrimaryColorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.4,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(200)),
      ),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.05),
          const Text("Sweetella", style: AppTextStyles.text32BoldWhite),
          Image.asset(
            "assets/images/doughnut.png",
            height: screenHeight * 0.15,
            width: screenWidth * 0.35,
          ),
        ],
      ),
    );
  }
}
