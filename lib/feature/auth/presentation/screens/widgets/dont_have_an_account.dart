import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/sign_up_screen.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "don't have an account? ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontFamily: 'Nunito',
            fontVariations: [FontVariation('wght', 600)],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontVariations: [FontVariation('wght', 900)],
            ),
          ),
        ),
      ],
    );
  }
}
