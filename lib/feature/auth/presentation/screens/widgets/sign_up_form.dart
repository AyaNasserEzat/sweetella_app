import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/custom_text_field.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/aleardy_have_an_account.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/forgot_password.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/white_card.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      height: 410,
      child: Column(
        spacing: 5,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 24,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontVariations: [FontVariation('wght', 900)],
            ),
          ),
          const CustomTextField(
            labelText: "Name",
            hintText: "Name",
            prefixIcon: Icons.person_outline,
          ),

          const SizedBox(height: 15),
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

          ForgotPassword(),
          const SizedBox(height: 4),
          CustomButton(onPressed: () {}, text: "Sign Up"),
          const SizedBox(height: 6),
          AleardyHaveAnAccount(),
        ],
      ),
    );
  }
}
