import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/favorites/data/models/favorites_model.dart';

abstract class FavoritesRepo {
  Future<Either<Failure, String>> addToFavorites({required String productId});
  Future<Either<Failure, String>> removeFromFavorites({required String productId});
  Future<Either<Failure, List<FavoritesModel>>> getFavorites();
  //Future<bool> isFavorite({required String productId});
}
