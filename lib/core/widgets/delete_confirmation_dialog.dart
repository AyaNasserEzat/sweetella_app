import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';

Future<bool> showDeleteConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.greySmallLigt),
            ),
            title: Text(title, style: AppTextStyles.text18BoldDarkGray),
            content: Text(
              message,
              style: AppTextStyles.text16Grey.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: [
              CustomButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                text: 'Cancel',
                width: 95,
                backgroundColor: AppColors.white,
                textColor: AppColors.primaryColor,
                verticalPadding: 10,
              ),
              CustomButton(
                onPressed: () {
                  Navigator.pop(dialogContext, true);
                },
                text: 'Delete',
                width: 95,
                verticalPadding: 10,
              ),
            ],
          );
        },
      ) ??
      false;
}
