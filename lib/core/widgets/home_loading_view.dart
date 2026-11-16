import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sweetella/core/widgets/products_loading_view.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_list_view.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      children: [
        Skeletonizer(
          enabled: true,
          child: GategoryListView(
            categories: List.generate(10, (index) => CategoryModel.empty()),
          ),
        ),
        LoadingProductsView(),
      ],
    );
  }
}
