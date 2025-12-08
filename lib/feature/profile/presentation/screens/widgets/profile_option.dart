import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

Widget buildProfileOption({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  Color? color,
}) {
  return ListTile(
    leading: Icon(icon, color: color ?? AppColors.primaryColor),
    title: Text(
      title,
      style: AppTextStyles.text16BoldBlack.copyWith(
        color: color ?? AppColors.greyDark,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    onTap: onTap,
  );
}
