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
      final cartItemId = item.generateCartItemId(item);
      final docRef = firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(cartItemId);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // If exact same product + attribute combo exists, increment quantity
        final currentQty = docSnapshot.data()?['quantity'] ?? 0;
        await docRef.update({'quantity': currentQty + item.quantity});
      } else {
        await docRef.set(item.toJson());
      }
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
          .doc(item.generateCartItemId(item))
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
  Future<void> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
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
