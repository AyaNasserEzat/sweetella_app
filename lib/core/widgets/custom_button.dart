import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final Color? textColor;
  final IconData? icon;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRadius = 14,
    this.borderColor = AppColors.primaryColor,
    this.backgroundColor = AppColors.primaryColor,
    this.icon,
    this.textColor = AppColors.white,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: borderColor),
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            children: [
              icon != null
                  ? Icon(icon, size: 25, color: textColor)
                  : SizedBox.shrink(),
              Text(text, style: TextStyle(fontSize: 18, color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
