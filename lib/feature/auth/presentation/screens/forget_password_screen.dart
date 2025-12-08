import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/forget_password_form.dart';
import 'widgets/bottom_image.dart';
import 'widgets/primary_color_container.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(),
          PrimaryColorContainer(),
          ForgetPasswordForm(),
          BottomImage(),
        ],
      ),
    );
  }
}
