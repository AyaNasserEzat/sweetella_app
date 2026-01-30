import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/data/services/product_firebase_service.dart';

class ProductRepoImp {
  final ProductFirebaseService productFirebaseService;
  ProductRepoImp(this.productFirebaseService);
  Future<Either<Failure, List<ProductModel>>> getProducts({required String categoryId}) async {
    try {
      final res = await productFirebaseService.getProducts(categoryId: categoryId);
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

   Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final res = await productFirebaseService.getAllCategories();
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
