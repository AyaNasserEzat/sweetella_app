import 'package:sweetella/feature/favorites/data/models/favorites_model.dart';

abstract class FavoriesState {}

class FavoriesInitial extends FavoriesState {}

class FavoriesLoading extends FavoriesState {}

class FavoriesLoaded extends FavoriesState {
  final List<FavoritesModel> favorites;
  FavoriesLoaded({required this.favorites});
}

class FavoriesError extends FavoriesState {
  final String message;
  FavoriesError({required this.message});
}

class AddToFavoritesSucessfullyState extends FavoriesState {
  final String message;
  AddToFavoritesSucessfullyState({required this.message});
}
class AddToFavoritesErrorState extends FavoriesState {
  final String message;
  AddToFavoritesErrorState({required this.message});
}
class RemoveFromFavoritesSucessfullyState extends FavoriesState {
  final String message;
  RemoveFromFavoritesSucessfullyState({required this.message});
}
class RemoveFromFavoritesErrorState extends FavoriesState {
  final String message;
  RemoveFromFavoritesErrorState({required this.message});
}