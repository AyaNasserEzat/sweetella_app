import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/data/repositories/cart_repo.dart';

class CartFirebaseRepoImp implements CartRepo {
  final CartRemoteDataSource cartRemoteDataSource;
  CartFirebaseRepoImp({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, String>> addToCart({required CartItemModel item}) async {
    try {
      await cartRemoteDataSource.addToCart(item: item);
      return right('add to cart successfully');
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeFromCart({required CartItemModel item}) async {
    try {
      await cartRemoteDataSource.removeFromCart(item: item);
      return right('remove from cart successfully');
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> getCartItems() async {
    try {
      final res = await cartRemoteDataSource.getCartItems();
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateCartItemQuantity({required String cartItemId, required int quantity}) async {
    try {
      await cartRemoteDataSource.updateCartItemQuantity(cartItemId: cartItemId, quantity: quantity);
      return right('cart item quantity updated successfully');
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
