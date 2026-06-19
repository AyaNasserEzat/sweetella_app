import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import '../../../data/repositories/product_repo_imp.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepoImp productRepo;

  ProductCubit(this.productRepo) : super(ProductInitial());

  List<CategoryModel> allCategories = [];
  List<ProductModel> allproducts = [];
  int selectedCategoryIndex = 0;
  void changeSelectedCategoryIndex(int index) {
    selectedCategoryIndex = index;
    emit(ChangeSelectedCategoryIndexState());
  }

  Future<void> getAllProducts() async {
    emit(ProductLoading());
    final result = await productRepo.getAllProducts();
    result.fold((failure) => emit(ProductError(failure.message)), (products) {
      allproducts = products;
      emit(ProductSuccess(products));
    });
  }

  Future<void> getProducts({required String categoryId}) async {
    emit(ProductLoading());
    final result = await productRepo.getProducts(categoryId: categoryId);
    result.fold((failure) => emit(ProductError(failure.message)), (products) {
      emit(ProductSuccess(products));
    });
  }

  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoading());
    final result = await productRepo.getAllCategories();
    result.fold((failure) => emit(GetAllCategoriesError(failure.message)), (
      categories,
    ) {
      allCategories = categories;
      emit(GetAllCategoriesSuccess(categories));
    });
  }
}
