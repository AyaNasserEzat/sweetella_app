import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

class ProductFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await firestore.collection('Products').get();
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> getProducts({required String categoryId}) async {
    try {
      final snapshot = await firestore
          .collection('Products')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await firestore.collection('categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }
}
