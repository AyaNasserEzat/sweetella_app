import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

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
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff484848),
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  fontVariations: [FontVariation('wght', 900)],
                ),
                children: [
                  TextSpan(
                    text: "like to order\n",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      fontVariations: [FontVariation('wght', 900)],
                    ),
                  ),
                  const TextSpan(
                    text: "today?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff484848),
                      fontWeight: FontWeight.bold,
                      fontVariations: [FontVariation('wght', 900)],
                      fontFamily: 'Nunito',
                    ),
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
