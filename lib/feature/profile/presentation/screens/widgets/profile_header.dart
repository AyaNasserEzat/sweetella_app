import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.backgroundColor,
          child: Icon(
            Icons.person,
            size: 50,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text('Aya Nasser', style: AppTextStyles.text20BoldDarkGray),
        const SizedBox(height: 4),
        Text(
          'Aya.nasser@example.com',
          style: AppTextStyles.text16BoldBlack.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}