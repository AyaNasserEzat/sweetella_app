part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}
class CartLoading extends CartState {}
class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  CartLoaded({required this.cartItems});
}
class CartError extends CartState {
  final String message;
  CartError({required this.message});
}


class AddToCartLoading extends CartState {
  String productId;
  AddToCartLoading({required this.productId});
}
class AddToCartSucess extends CartState {
  CartItemModel item;
  AddToCartSucess({required this.item});
}

class AddToCartError extends CartState {
  String message;
  AddToCartError({required this.message});
}



class RemoveFromCartLoading extends CartState {
  String productId;
  RemoveFromCartLoading({required this.productId});
}
class RemoveFromCartSucess extends CartState {
  CartItemModel item;
  RemoveFromCartSucess({required this.item});
}

class RemoveFromCartError extends CartState {
  String message;
  RemoveFromCartError({required this.message});
}