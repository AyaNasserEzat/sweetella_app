import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/error_dialog.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_state.dart';
import 'package:sweetella/feature/home/presentation/screens/bottom_nav_bar.dart';
import 'package:sweetella/core/helper/extension.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is SignInLoading ||
          current is SignInSuccess ||
          current is SignInError,
      listener: (context, state) {
        if (state is SignInLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        } else if (state is SignInSuccess) {
          context.pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else if (state is SignInError) {
          showErrorDialog(context, state.message);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
