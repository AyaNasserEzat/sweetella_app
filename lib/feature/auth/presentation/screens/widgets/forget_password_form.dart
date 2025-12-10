import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_text_field.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/white_card.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_cubit.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return WhiteCard(
      child: Column(
        spacing: 10,
        children: [
          const Text("Forget Password", style: AppTextStyles.text24BoldPink),
          const SizedBox(height: 5),
          CustomTextField(
            controller: authCubit.forgetPassordEmailController,
            labelText: "Email",
            hintText: "Email",
            prefixIcon: Icons.email_outlined,
          ),

          const SizedBox(height: 15),

          CustomButton(
            onPressed: () {
              authCubit.resetPassword();
            },
            text: "Reset Password",
          ),
        ],
      ),
    );
  }
}

