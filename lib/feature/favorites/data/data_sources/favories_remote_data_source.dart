import 'package:sweetella/feature/favorites/data/models/favorites_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<void> addToFavorites({required String productId});
  Future<void> removeFromFavorites({required String productId});
  Future<List<FavoritesModel>> getFavorites();
}
