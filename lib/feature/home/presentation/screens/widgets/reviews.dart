
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              Icons.star,
              color: index < 4 ? AppColors.primaryColor : Colors.grey,
            );
          }),
        ),
        const SizedBox(width: 8),
        const Text(
          '4.5',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
