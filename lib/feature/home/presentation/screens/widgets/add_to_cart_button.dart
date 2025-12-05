
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        onPressed: () {
          // Add to cart functionality
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
        child: const Text(
          'Add to Cart',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
