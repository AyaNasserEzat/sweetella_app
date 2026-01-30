import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repo_imp.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepoImp productRepo;

  ProductCubit(this.productRepo) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());
    final result = await productRepo.getProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductSuccess(products)),
    );
  }

  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoading());
    final result = await productRepo.getAllCategories();
    result.fold(
      (failure) => emit(GetAllCategoriesError(failure.message)),
      (categories) => emit(GetAllCategoriesSuccess(categories)),
    );
  }
}
