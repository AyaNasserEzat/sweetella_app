import 'package:flutter/material.dart';

class DonutTitleAndPrice extends StatelessWidget {
  const DonutTitleAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Delicious Donut',
          style: TextStyle(
            fontSize: 24,

            color: Color(0xffe26784),
            fontFamily: 'Nunito',
            fontVariations: [FontVariation('wght', 900)],
          ),
        ),
        SizedBox(height: 8),
        Text(
          r'Price: $3.99',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
