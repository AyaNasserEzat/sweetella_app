import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/auth/presentation/screens/login_screen.dart';

class AleardyHaveAnAccount extends StatelessWidget {
  const AleardyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.034; // Responsive font size
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: AppTextStyles.text16BoldBlack.copyWith(
            color: Colors.black54,
            fontSize: fontSize,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontVariations: [const FontVariation('wght', 900)],
            ),
          ),
        ),
      ],
    );
  }
}
