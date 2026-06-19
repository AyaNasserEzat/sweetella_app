import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ChangeSelectedCategoryIndexState extends ProductState {}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  const ProductSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetAllCategoriesLoading extends ProductState {}

class GetAllCategoriesSuccess extends ProductState {
  final List<CategoryModel> categories;
  GetAllCategoriesSuccess(this.categories);
}

class GetAllCategoriesError extends ProductState {
  final String message;
  GetAllCategoriesError(this.message);
}
