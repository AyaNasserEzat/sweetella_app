import 'package:sweetella/feature/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart({required CartItemModel item});
  Future<void> removeFromCart({required CartItemModel item});
  Future<List<CartItemModel>> getCartItems();
  Future<void> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  });
}
