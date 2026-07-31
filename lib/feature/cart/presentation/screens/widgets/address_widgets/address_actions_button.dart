import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

class AddressActionButton extends StatelessWidget {
  const AddressActionButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: AppColors.primaryColor.withValues(alpha: 0.1),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: AppColors.primaryColor, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}
