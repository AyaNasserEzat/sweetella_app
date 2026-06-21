import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ProductModel>>> searchProducts({
    required String query,
  });
}
