import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
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

            const SizedBox(height: 2),
          ],
        ),

        Image.asset('assets/images/donuts_image.png', height: 45, width: 45),
      ],
    );
  }
}
