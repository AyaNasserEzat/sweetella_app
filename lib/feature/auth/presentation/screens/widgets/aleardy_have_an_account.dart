import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/login_screen.dart';

class AleardyHaveAnAccount extends StatelessWidget {
  const AleardyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Aleardy't have an account? ",
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
                  return LoginScreen();
                },
              ),
            );
          },
          child: const Text(
            "Sign In",
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
