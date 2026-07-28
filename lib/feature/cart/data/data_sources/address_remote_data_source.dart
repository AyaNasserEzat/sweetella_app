import 'package:sweetella/feature/cart/data/models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<void> addAddress({required AddressModel address});
  Future<List<AddressModel>> getAddresses();
  Future<void> editAddress({required AddressModel address});
}
