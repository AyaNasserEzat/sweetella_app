import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_item.dart';

class GategoryListView extends StatelessWidget {
  const GategoryListView({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              final cubit = context.read<ProductCubit>();
              cubit.changeSelectedCategoryIndex(index);
              if (index == 0) {
                cubit.getAllProducts();
              } else {
                cubit.getProducts(categoryId: categories[index].id);
              }
            },
            child: CategoryItem(categoryModel: categories[index], index: index),
          );
        },
      ),
    );
  }
}
