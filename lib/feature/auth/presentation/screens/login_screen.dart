import 'package:flutter/material.dart';
import 'widgets/bottom_image.dart';
import 'widgets/primary_color_container.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbe9e7),
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
