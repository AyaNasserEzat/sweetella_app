import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/auth/presentation/screens/sign_up_screen.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "don't have an account? ",
            style: AppTextStyles.text16SmiyBoldblack54,
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
            child: Text("Sign Up", style: AppTextStyles.text14BoldPink),
          ),
        ],
      ),
    );
  }
}
