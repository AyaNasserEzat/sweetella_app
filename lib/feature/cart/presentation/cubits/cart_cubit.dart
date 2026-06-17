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
    result.fold((failure) => emit(CartError(message: failure.message)), (
      items,
    ) {
      cartItems = items;
      emit(CartLoaded(cartItems: cartItems));
    });
  }

  Future<void> addToCart(CartItemModel cartItemModel) async {
    // Optimistic update
    cartItems.add(cartItemModel);
    emit(CartLoaded(cartItems: List.from(cartItems)));

    final result = await cartRepo.addToCart(item: cartItemModel);

    result.fold((failure) {
      // Rollback
      cartItems.removeWhere(
        (item) => item.productId == cartItemModel.productId,
      );
      emit(CartError(message: failure.message));
      emit(CartLoaded(cartItems: List.from(cartItems)));
    }, (_) {});
  }

  Future<void> removeFromCart(CartItemModel cartItemModel) async {
    // Optimistic update
    cartItems.removeWhere((item) => item.productId == cartItemModel.productId);
    emit(CartLoaded(cartItems: List.from(cartItems)));

    final result = await cartRepo.removeFromCart(item: cartItemModel);

    result.fold((failure) {
      // Rollback
      cartItems.add(cartItemModel);
      emit(CartError(message: failure.message));
      emit(CartLoaded(cartItems: List.from(cartItems)));
    }, (_) async {});
  }

  Future<void> toogleAddOrRemove(CartItemModel cartItemModel) async {
    if (isInCart(cartItemModel)) {
      await removeFromCart(cartItemModel);
    } else {
      await addToCart(cartItemModel);
    }
  }

  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    final result = await cartRepo.updateCartItemQuantity(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    result.fold((failure) => emit(CartError(message: failure.message)), (
      message,
    ) async {
      await getCartItems();
    });
  }

  bool isInCart(CartItemModel cartItemModel) {
    return cartItems.any((item) => item.productId == cartItemModel.productId);
  }
}
