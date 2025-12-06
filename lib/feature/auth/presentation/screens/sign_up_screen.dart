import 'package:flutter/material.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/sign_up_form.dart';
import 'widgets/bottom_image.dart';
import 'widgets/primary_color_container.dart';
import 'widgets/login_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbe9e7),
      body: Stack(
        alignment: Alignment.topCenter,
        children:  [
          Container(),
          BottomImage(),
          PrimaryColorContainer(),
          SignUpForm(),
          
        ],
      ),
    );
  }
}
