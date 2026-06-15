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

  Future<void> addToCart(CartItemModel cartItemModel) async {
    emit(AddToCartLoading(productId: cartItemModel.productId));
    final result = await cartRepo.addToCart(item: cartItemModel);
    result.fold(
      (failure) => emit(AddToCartError(message: failure.message)),
      (message) async {
       cartItems.add(cartItemModel);
        emit(AddToCartSucess(item: cartItemModel, ));
       
      },
    );
  }

  Future<void> removeFromCart(CartItemModel cartItemModel) async {
    emit(RemoveFromCartLoading(productId: cartItemModel.productId));
    final result = await cartRepo.removeFromCart(item: cartItemModel);
    result.fold(
      (failure) => emit(RemoveFromCartError(message: failure.message)),
      (message) async {
         cartItems.removeWhere(
        (item) => item.productId == cartItemModel.productId,
      );
        emit(RemoveFromCartSucess(item: cartItemModel, ));
      
      },
    );
  }
Future<void> toogleAddOrRemove(CartItemModel cartItemModel) async {
  if (isInCart(cartItemModel)) {
    await removeFromCart(cartItemModel);
  } else {
    await addToCart(cartItemModel);
  }
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

  bool isInCart(CartItemModel cartItemModel) {
    return cartItems.any((item) => item.productId == cartItemModel.productId);
  }
}
