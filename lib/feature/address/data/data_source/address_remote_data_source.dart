import 'package:sweetella/feature/address/data/models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<AddressModel> addAddress({required AddressModel address});
  Future<List<AddressModel>> getAddresses();
  Future<void> editAddress({required AddressModel address});
  Future<void> deleteAddress({required String addressId});
}
