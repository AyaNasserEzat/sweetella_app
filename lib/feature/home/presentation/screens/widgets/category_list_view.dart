import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_item.dart';

class GategoryListView extends StatefulWidget {
  const GategoryListView({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  State<GategoryListView> createState() => _GategoryListViewState();
}

class _GategoryListViewState extends State<GategoryListView> {
  @override
  void initState() {
    final cubit = context.read<ProductCubit>();
    cubit.getProducts(categoryId: widget.categories[0].id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<ProductCubit>(
                context,
              ).changeSelectedCategoryIndex(index);
              BlocProvider.of<ProductCubit>(
                context,
              ).getProducts(categoryId: widget.categories[index].id);
            },
            child: CategoryItem(
              categoryModel: widget.categories[index],
              index: index,
            ),
          );
        },
      ),
    );
  }
}
