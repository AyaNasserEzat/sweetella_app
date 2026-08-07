import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/cart/data/repositories/cart_repo.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  CartCubit({required this.cartRepo}) : super(CartInitial());

  List<CartItemModel> cartItems = [];

  // Helper helper to clean up equality checks
  String _getItemId(CartItemModel item) => item.generateCartItemId(item);

  int getItemQuantity(CartItemModel cartItemModel) {
    final index = cartItems.indexWhere(
      (item) => _getItemId(item) == _getItemId(cartItemModel),
    );

    if (index == -1) return 0;

    return cartItems[index].quantity;
  }

  Future<void> getCartItems() async {
    emit(CartLoading());
    final result = await cartRepo.getCartItems();
    result.fold((failure) => emit(CartError(message: failure.message)), (
      items,
    ) {
      cartItems = items;
      emit(CartLoaded(cartItems: List.from(cartItems)));
    });
  }

  Future<void> addToCart(CartItemModel cartItemModel) async {
    // Check if the exact attribute combo already exists to update quantity instead of duplicating
    final existingIndex = cartItems.indexWhere(
      (item) => _getItemId(item) == _getItemId(cartItemModel),
    );

    List<CartItemModel> previousState = List.from(cartItems);

    if (existingIndex != -1) {
      final existingItem = cartItems[existingIndex];
      cartItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + cartItemModel.quantity,
      );
    } else {
      cartItems.add(cartItemModel);
    }

    emit(CartLoaded(cartItems: List.from(cartItems)));

    final result = await cartRepo.addToCart(item: cartItemModel);

    result.fold((failure) {
      // Rollback to exact previous state
      cartItems = previousState;
      emit(CartError(message: failure.message));
      emit(CartLoaded(cartItems: List.from(cartItems)));
    }, (_) {});
  }

  Future<void> removeFromCart(CartItemModel cartItemModel) async {
    List<CartItemModel> previousState = List.from(cartItems);

    // FIXED: Match by generated unique ID, not just productId
    cartItems.removeWhere(
      (item) => _getItemId(item) == _getItemId(cartItemModel),
    );
    emit(CartLoaded(cartItems: List.from(cartItems)));

    final result = await cartRepo.removeFromCart(item: cartItemModel);

    result.fold((failure) {
      // Rollback
      cartItems = previousState;
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

  Future<void> updateCartItemQuantity({
    required CartItemModel cartItemModel,
    required int quantity,
  }) async {
    // FIXED: Match by unique combination ID
    final index = cartItems.indexWhere(
      (e) => _getItemId(e) == _getItemId(cartItemModel),
    );

    if (index == -1) return;
    final updatedCartItem = cartItems[index].copyWith(quantity: quantity);

    cartItems[index] = updatedCartItem;
    emit(CartLoaded(cartItems: List.from(cartItems)));

    // FIXED: Pass the true unique cartItemId to your repo layer, NOT the base productId
    final result = await cartRepo.updateCartItemQuantity(
      cartItemId: _getItemId(cartItemModel),
      quantity: updatedCartItem.quantity,
    );

    result.fold((failure) {
      // Rollback
      cartItems[index] = cartItemModel;
      emit(CartLoaded(cartItems: List.from(cartItems)));
      emit(CartError(message: failure.message));
    }, (message) async {});
  }

  bool isInCart(CartItemModel cartItemModel) {
    // FIXED: Match by full unique attribute signature
    return cartItems.any(
      (item) => _getItemId(item) == _getItemId(cartItemModel),
    );
  }

  Future<void> clearCart() async {
    final result = await cartRepo.clearCart();

    result.fold(
      (failure) {
        emit(CartError(message: failure.message));
      },
      (_) {
        cartItems.clear();

        emit(CartLoaded(cartItems: []));
      },
    );
  }
}
