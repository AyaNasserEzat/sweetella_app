import 'package:flutter/material.dart';
import 'package:sweetella/core/helper/extension.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/categories_bloc_builder.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/products_bloc_builder.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/home_header.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/search_container.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.w * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          top: 35,
          right: horizontalPadding,
          bottom: context.h * 0.15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- HEADER ----------------
            HomeHeader(),
            const SizedBox(height: 25),
            // ---------------- SEARCH BAR ----------------
            SearchContainer(),

            const SizedBox(height: 25),

            // ---------------- CATEGORIES ----------------
            Text("Categories", style: AppTextStyles.text18BoldDarkGray),
            const SizedBox(height: 12),

            CategoriesBlocBuilder(),
            // ---------------- GridView ----------------
            const SizedBox(height: 30),

            ProductsBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
