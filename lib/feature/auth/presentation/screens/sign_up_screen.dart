import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/aleardy_have_an_account.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/sign_up_form.dart';
import 'widgets/bottom_image.dart';
import 'widgets/primary_color_container.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(),
          BottomImage(),
          PrimaryColorContainer(),
          SignUpForm(),
        ],
      ),
    );
  }
}
