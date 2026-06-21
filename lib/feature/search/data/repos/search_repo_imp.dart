import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/search/data/data_source/search_remote_data_source.dart';
import 'package:sweetella/feature/search/data/repos/search_repo.dart';

class SearchRepoImp extends SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  SearchRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> searchProducts({
    required String query,
  }) async {
    try {
      final results = await remoteDataSource.searchProducts(query: query);
      return right(results);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
