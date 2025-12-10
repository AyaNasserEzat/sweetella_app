import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/error_dialog.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_state.dart';
import 'package:sweetella/core/helper/extension.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  const ForgetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is ForgetPasswordLoading ||
          current is ForgetPasswordSuccess ||
          current is ForgetPasswordError,
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        } else if (state is ForgetPasswordSuccess) {
          context.pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 32,
              ),
              content: const Text('If an account with this email exists, a password reset email has been sent.'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop(); // close dialog
                    Navigator.pop(context); // back to login
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else if (state is ForgetPasswordError) {
          showErrorDialog(context, state.message);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
