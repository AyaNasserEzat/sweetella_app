import 'package:flutter/material.dart';

class DonutDescription extends StatelessWidget {
  const DonutDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
            fontVariations: [FontVariation('wght', 900)],
          ),
        ),
        SizedBox(height: 8),
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          'This donut is made with the finest ingredients and topped with a delicious glaze. Perfect for any time of the day!',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}