import 'package:flutter/material.dart';

class BottomImage extends StatelessWidget {
  const BottomImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: -screenHeight * 0.07, // Adjusted to make half the image appear
      right: -screenWidth * 0.15,
      child: Image.asset(
        'assets/images/donuts_image.png',
        height: screenHeight * 0.2,
        width: screenWidth * 0.4,
      ),
    );
  }
}