import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_text_field.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/dont_have_an_account.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/white_card.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Column(
        spacing: 5,
        children: [
          const Text(
            "Sign In",
            style: AppTextStyles.text24BoldPink
          ),
          const CustomTextField(
            labelText: "Email",
            hintText: "Email",
            prefixIcon: Icons.email_outlined,
          ),

          const SizedBox(height: 15),

          // Password
          const CustomTextField(
            labelText: "Password",
            hintText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: true,
          ),

          const SizedBox(height: 20),
          CustomButton(onPressed: () {}, text: "Sign In"),
          const SizedBox(height: 12),
          DontHaveAnAccount(),
        ],
      ),
    );
  }
}
