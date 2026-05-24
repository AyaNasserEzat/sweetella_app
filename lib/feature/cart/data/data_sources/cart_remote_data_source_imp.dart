import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/feature/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';

class CartRemoteDataSourceImp implements CartRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> addToCart({required CartItemModel item}) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(item.productId)
          .set(item.toJson());
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart({required CartItemModel item}) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(item.productId)
          .delete();
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .orderBy('addedAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => CartItemModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<void> updateCartItemQuantity({required String cartItemId, required int quantity}) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(cartItemId)
          .update({'quantity': quantity});
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }
}
