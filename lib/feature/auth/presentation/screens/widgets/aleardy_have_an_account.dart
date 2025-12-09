import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/auth/presentation/screens/login_screen.dart';

class AleardyHaveAnAccount extends StatelessWidget {
  const AleardyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            "Already have an account? ",
            style: AppTextStyles.text16SmiyBoldblack54
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
              style: AppTextStyles.text14BoldPink,),
          ),
        ],
      ),
    );
  }
}
