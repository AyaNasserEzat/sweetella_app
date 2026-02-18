import 'package:sweetella/feature/favorites/data/models/favorites_model.dart';

import 'package:equatable/equatable.dart';

abstract class FavoriesState extends Equatable {
  const FavoriesState();

  @override
  List<Object?> get props => [];
}


class FavoriesInitial extends FavoriesState {
  const FavoriesInitial();
}
class FavoriesLoading extends FavoriesState {
  const FavoriesLoading();
}


class FavoriesLoaded extends FavoriesState {
  final Set<String> favoritesIds;

  const FavoriesLoaded({required this.favoritesIds});

  @override
  List<Object?> get props => [favoritesIds];
}


class FavoriesError extends FavoriesState {
  final String message;

  const FavoriesError({required this.message});

  @override
  List<Object?> get props => [message];
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