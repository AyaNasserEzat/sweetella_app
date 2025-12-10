import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/error_dialog.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_state.dart';
import 'package:sweetella/feature/home/presentation/screens/bottom_nav_bar.dart';
import 'package:sweetella/core/helper/extension.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is SignUpLoading ||
          current is SignUpSuccess ||
          current is SignUpError,
      listener: (context, state) {
        if (state is SignUpLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        } else if (state is SignUpSuccess) {
          context.pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else if (state is SignUpError) {
          showErrorDialog(context, state.message);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
