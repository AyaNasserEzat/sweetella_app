import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/category_state.dart';
import '../../../data/repositories/product_repo_imp.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductRepoImp productRepo;

  CategoryCubit(this.productRepo) : super(CategoryInitial());

  List<CategoryModel> allCategories = [];

  int selectedCategoryIndex = 0;
  void changeSelectedCategoryIndex(int index) {
    selectedCategoryIndex = index;
    emit(ChangeSelectedCategoryIndexState());
  }

  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoading());
    final result = await productRepo.getAllCategories();
    result.fold(
      (failure) {
        emit(GetAllCategoriesError(failure.message));
      },
      (categories) {
        allCategories = categories;
        emit(GetAllCategoriesSuccess(categories));
      },
    );
  }
}
