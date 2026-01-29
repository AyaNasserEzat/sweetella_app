import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_text_field.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/dont_have_an_account.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/forgot_password.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/white_card.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return WhiteCard(
      child: Column(
        spacing: 5,
        children: [
          const Text("Sign In", style: AppTextStyles.text24BoldPink),
          CustomTextField(
            controller: authCubit.signInEmailController,
            labelText: "Email",
            hintText: "Email",
            prefixIcon: Icons.email_outlined,
          ),

          const SizedBox(height: 15),

          // Password
          CustomTextField(
            controller: authCubit.signInPasswordController,
            labelText: "Password",
            hintText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            isPassword: true,
            suffixIcon: Icon(Icons.remove_red_eye_outlined),
          ),

          const ForgotPassword(),
          const SizedBox(height: 4),
          CustomButton(
            onPressed: () {
              authCubit.signIn();
            },
            text: "Sign In",
          ),
          const SizedBox(height: 6),
          const DontHaveAnAccount(),
        ],
      ),
    );
  }
}
