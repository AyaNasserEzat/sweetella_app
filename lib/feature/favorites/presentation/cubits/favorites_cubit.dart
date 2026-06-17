import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/favorites/data/repositories/favorites_firebase_repo.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favories_state.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

class FavoritesCubit extends Cubit<FavoriesState> {
  final FavoritesRepo favoritesRepo;

  FavoritesCubit({required this.favoritesRepo}) : super(FavoriesInitial());
  Set<String> favoriteIds = {};
  Future<void> getFavoritesIds() async {
    emit(FavoriesLoading());

    final result = await favoritesRepo.getFavorites();
    result.fold(
      (failure) {
        emit(FavoriesError(message: failure.message));
      },
      (favorites) {
        favoriteIds = favorites.map((e) => e.productId).toSet();
        emit(FavoriesLoaded(favoritesIds: favoriteIds));
      },
    );
  }

  List<ProductModel> getFavorites(List<ProductModel> allProducts) {
    return allProducts
        .where((product) => favoriteIds.contains(product.id))
        .toList();
  }

  Future<void> addToFavorites({required String productId}) async {
    // Optimistic update

    favoriteIds = {...favoriteIds, productId};
    emit(FavoriesLoaded(favoritesIds: favoriteIds));
    final result = await favoritesRepo.addToFavorites(productId: productId);
    result.fold((failure) {
      // Rollback
      favoriteIds = favoriteIds.where((id) => id != productId).toSet();
      emit(FavoriesLoaded(favoritesIds: favoriteIds));

      emit(FavoriesError(message: failure.message));
    }, (_) {});
  }

  Future<void> removeFromFavorites({required String productId}) async {
    // Optimistic update
    favoriteIds = favoriteIds.where((id) => id != productId).toSet();
    emit(FavoriesLoaded(favoritesIds: favoriteIds));

    final result = await favoritesRepo.removeFromFavorites(
      productId: productId,
    );
    result.fold((failure) {
      // Rollback
      favoriteIds = {...favoriteIds, productId};
      emit(FavoriesLoaded(favoritesIds: favoriteIds));
      emit(FavoriesError(message: failure.message));
    }, (_) {});
  }

  bool isFavorite({required String productId}) =>
      favoriteIds.contains(productId);

  Future<void> toogleFavorite({required String productId}) async {
    if (isFavorite(productId: productId)) {
      await removeFromFavorites(productId: productId);
    } else {
      await addToFavorites(productId: productId);
    }
  }
}
