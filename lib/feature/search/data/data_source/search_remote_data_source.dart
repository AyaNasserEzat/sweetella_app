import 'package:sweetella/feature/home/data/models/product_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<ProductModel>> searchProducts({required String query});
}
