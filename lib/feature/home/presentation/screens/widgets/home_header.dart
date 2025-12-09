import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.1; // 10% of screen width

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: RichText(
                  text: TextSpan(
                    text: "What Would You\n",
                    style: AppTextStyles.text20BoldDarkGray,
                    children: [
                      TextSpan(
                        text: "like to order\n",
                        style: AppTextStyles.text24BoldPink,
                      ),
                      const TextSpan(
                        text: "today?",
                        style: AppTextStyles.text20BoldDarkGray,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),
            ],
          ),
        ),
        SizedBox(
          height: imageSize,
          width: imageSize,
          child: Image.asset('assets/images/doughnut.png', fit: BoxFit.contain),
        ),
      ],
    );
  }
}
