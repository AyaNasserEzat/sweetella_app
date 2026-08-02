import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';

abstract class AddressRepo {
  Future<Either<Failure, AddressModel>> addAddress({
    required AddressModel address,
  });
  Future<Either<Failure, List<AddressModel>>> getAddresses();
  Future<Either<Failure, String>> editAddress({required AddressModel address});
  Future<Either<Failure, String>> deleteAddress({required String addressId});
}
