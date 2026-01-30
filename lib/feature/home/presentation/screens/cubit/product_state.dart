import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  ProductSuccess(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
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