import 'package:flutter/material.dart';
import 'package:sweetella/core/helper/extension.dart';

class BottomImage extends StatelessWidget {
  const BottomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -context.h * 0.07, //  to make half the image appear
      right: -context.w * 0.15,
      child: Image.asset(
        'assets/images/donuts_image.png',
        height: context.h * 0.2,
        width: context.w * 0.4,
      ),
    );
  }
}
