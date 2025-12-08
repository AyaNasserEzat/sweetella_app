import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/auth/presentation/screens/forget_password_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return ForgetPasswordScreen();
      }));
        },
        child: Text(
          'Forgot Password?',
          style: AppTextStyles.text16BoldBlack.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}