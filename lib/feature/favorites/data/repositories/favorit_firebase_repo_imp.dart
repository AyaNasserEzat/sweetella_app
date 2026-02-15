import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/favorites/data/data_sources/favories_remote_data_source.dart';
import 'package:sweetella/feature/favorites/data/models/favorites_model.dart';
import 'package:sweetella/feature/favorites/data/repositories/favorites_firebase_repo.dart';

class FavoritFirebaseRepoImp implements FavoritesRepo {
  final FavoritesRemoteDataSource favoritesRemoteDataSource;
  FavoritFirebaseRepoImp({required this.favoritesRemoteDataSource});
  @override
  Future<Either<Failure, String>> addToFavorites({
    required String productId,
  }) async {
    try {
      await favoritesRemoteDataSource.addToFavorites(productId: productId);
      return right('add to favorites successfully');
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<FavoritesModel>>> getFavorites() async {
    try {
      final res = await favoritesRemoteDataSource.getFavorites();
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeFromFavorites({
    required String productId,
  }) async {
    try {
      await favoritesRemoteDataSource.removeFromFavorites(productId: productId);
      return right('remove from favorites successfully');
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
