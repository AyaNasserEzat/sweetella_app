import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/search/presentation/screens/search_screen.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            Text('Search here...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
