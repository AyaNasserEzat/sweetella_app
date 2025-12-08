import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.title });
final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.text24BoldDarkGray,
    );
  }
}