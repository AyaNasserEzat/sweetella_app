import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, String>> addToCart({required CartItemModel item});
  Future<Either<Failure, String>> removeFromCart({required CartItemModel item});
  Future<Either<Failure, List<CartItemModel>>> getCartItems();
  Future<Either<Failure, String>> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  });
  Future<Either<Failure, void>> clearCart();
}
