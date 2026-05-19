import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/cart/data/repositories/cart_repo.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  CartCubit({required this.cartRepo}) : super(CartInitial());

  List<CartItemModel> cartItems = [];

  Future<void> getCartItems() async {
    emit(CartLoading());
    final result = await cartRepo.getCartItems();
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (items) {
        cartItems = items;
        emit(CartLoaded(cartItems: cartItems));
      },
    );
  }

  Future<void> addToCart(CartItemModel item) async {
    final result = await cartRepo.addToCart(item: item);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (message) async {
        emit(CartLoaded(cartItems: cartItems, ));
        await getCartItems();
      },
    );
  }

  Future<void> removeFromCart(String cartItemId) async {
    final result = await cartRepo.removeFromCart(cartItemId: cartItemId);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (message) async {
        await getCartItems();
      },
    );
  }

  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    final result = await cartRepo.updateCartItemQuantity(cartItemId: cartItemId, quantity: quantity);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (message) async {
        await getCartItems();
      },
    );
  }

  bool isInCart(String productId) {
    return cartItems.any((item) => item.productId == productId);
  }
}
