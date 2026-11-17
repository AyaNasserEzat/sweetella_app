import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/category_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/category_state.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesBlocBuilder extends StatelessWidget {
  const CategoriesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) {
        return current is GetAllCategoriesLoading ||
            current is GetAllCategoriesSuccess ||
            current is GetAllCategoriesError;
      },
      builder: (context, state) {
        if (state is GetAllCategoriesLoading) {
          return Skeletonizer(
            enabled: true,
            child: GategoryListView(
              categories: List.generate(10, (index) => CategoryModel.empty()),
            ),
          );
        } else if (state is GetAllCategoriesSuccess) {
          return GategoryListView(
            categories: [
              CategoryModel(
                id: '',
                name: 'All',
                imageUrl: 'assets/images/all.png',
              ),
              ...state.categories,
            ],
          );
        } else if (state is GetAllCategoriesError) {
          return Center(child: Text(state.message));
        }
        return SizedBox();
      },
    );
  }
}
