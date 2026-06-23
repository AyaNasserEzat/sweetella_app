import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/profile/presentation/cubits/profile_cubit.dart';
import 'package:sweetella/feature/profile/presentation/cubits/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.backgroundColor,
          child: Icon(Icons.person, size: 50, color: AppColors.primaryColor),
        ),
        const SizedBox(height: 16),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetProfileSuccess) {
              return Column(
                children: [
                  Text(
                    state.userModel.name,
                    style: AppTextStyles.text20BoldDarkGray,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.userModel.email,
                    style: AppTextStyles.text16BoldBlack.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              );
            } else if (state is GetProfileFailure) {
              return Text(state.errorMessage);
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
