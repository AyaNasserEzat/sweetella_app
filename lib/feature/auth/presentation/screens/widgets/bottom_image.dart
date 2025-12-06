import 'package:flutter/material.dart';

class BottomImage extends StatelessWidget {
  const BottomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -70, // Adjusted to make half the image appear
      right: -70,
      child: Image.asset(
        'assets/images/donuts_image.png',
        height: 200,
        width: 200,
      ),
    );
  }
}