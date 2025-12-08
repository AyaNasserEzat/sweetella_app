import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'widgets/bottom_image.dart';
import 'widgets/primary_color_container.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children:  [
          Container(),
          PrimaryColorContainer(),
          LoginForm(),
          BottomImage(),
        ],
      ),
    );
  }
}
