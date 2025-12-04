
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          // Add to cart functionality
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:Color(0xffe26784),
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
