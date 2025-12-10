import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/forget_password_bloc_listener.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/forget_password_form.dart';
import 'widgets/bottom_image.dart';
import 'widgets/primary_color_container.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(),
            PrimaryColorContainer(),
            ForgetPasswordForm(),
            BottomImage(),
            ForgetPasswordBlocListener(),
          ],
        ),
      ),
    );
  }
}
