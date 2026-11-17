import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class ChangeSelectedCategoryIndexState extends CategoryState {}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class GetAllCategoriesLoading extends CategoryState {}

class GetAllCategoriesSuccess extends CategoryState {
  final List<CategoryModel> categories;
  const GetAllCategoriesSuccess(this.categories);
}

class GetAllCategoriesError extends CategoryState {
  final String message;
  const GetAllCategoriesError(this.message);
}
