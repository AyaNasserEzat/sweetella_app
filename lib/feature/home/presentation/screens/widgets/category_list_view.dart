import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_chip.dart';

class GategoryListView extends StatelessWidget {
  const GategoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryChip("All", true),
          categoryChip("Pink Donuts", false),
          categoryChip("Chocolate", false),
          categoryChip("Caramel", false),
        ],
      ),
    );
  }
}
