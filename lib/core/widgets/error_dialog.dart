import 'package:flutter/material.dart';
import 'package:sweetella/core/helper/extension.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  context.pop();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.error, color: Colors.red, size: 32),
      content: Text(errorMessage, style: AppTextStyles.text16BoldBlack),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text('Got it', style: AppTextStyles.text16BoldBlack),
        ),
      ],
    ),
  );
}
