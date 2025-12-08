import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_list_view.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donuts_grid_view.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/home_header.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/search_bar.dart';

class DonutsHomeScreen extends StatelessWidget {
  const DonutsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          top: 35,
          right: 20,
          bottom: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- HEADER ----------------
            HomeHeader(),
            const SizedBox(height: 25),
            // ---------------- SEARCH BAR ----------------
            SearchTextFormField(),

            const SizedBox(height: 25),

            // ---------------- CATEGORIES ----------------
            Text("Categories", style: AppTextStyles.text18BoldDarkGray),
            const SizedBox(height: 12),

            GategoryListView(),
            // ---------------- GridView ----------------
            const SizedBox(height: 30),

            DountsGridView(),
          ],
        ),
      ),
    );
  }
}
