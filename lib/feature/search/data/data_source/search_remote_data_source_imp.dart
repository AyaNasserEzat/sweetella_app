import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/search/data/data_source/search_remote_data_source.dart';

class SearchRemoteDataSourceImp extends SearchRemoteDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> searchProducts({required String query}) async {
    try {
      final snapshot = await firestore
          .collection('Products')
          .where('name'.toLowerCase(), isGreaterThanOrEqualTo: query)
          .where('name'.toLowerCase(), isLessThanOrEqualTo: '$query\uf8ff')
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
}
