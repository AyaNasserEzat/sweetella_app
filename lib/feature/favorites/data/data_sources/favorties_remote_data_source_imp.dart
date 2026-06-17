import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/favorites/data/data_sources/favories_remote_data_source.dart';
import 'package:sweetella/feature/favorites/data/models/favorites_model.dart';

class FavortiesRemoteDataSourceImp implements FavoritesRemoteDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> addToFavorites({required String productId}) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(productId)
          .set({
            'productId': productId,
            'createdAt': FieldValue.serverTimestamp(),
          })
          .timeout(const Duration(seconds: 5));
    } on TimeoutException {
      throw AppException('faild to add item.check your internet connection and please try again.');
    } on AppException catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<List<FavoritesModel>> getFavorites() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .orderBy('createdAt', descending: true)
          .get();
      final list = snapshot.docs
          .map((document) => FavoritesModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<void> removeFromFavorites({required String productId}) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(productId)
          .delete();
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }
}
