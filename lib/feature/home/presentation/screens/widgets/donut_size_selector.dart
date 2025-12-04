import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/build_size_option.dart';

class DonutSizeSelector extends StatelessWidget {
  const DonutSizeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Size",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          spacing: 10,
          children: [
            BuildSizeOption(
              size: 'S',
              isSelected: true,
              onTap: () {
                // Handle size selection logic
              },
            ),
            BuildSizeOption(
              size: 'M',
              onTap: () {
                // Handle size selection logic
              },
            ),
            BuildSizeOption(
              size: 'L',
              onTap: () {
                // Handle size selection logic
              },
            ),
          ],
        ),
      ],
    );
  }
}
