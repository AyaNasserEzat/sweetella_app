import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/address/data/data_source/address_remote_data_source.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/address/data/repositories/address_repo.dart';

class AddressRepoImp implements AddressRepo {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, AddressModel>> addAddress({
    required AddressModel address,
  }) async {
    try {
      final res = await remoteDataSource.addAddress(address: address);
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    try {
      final addresses = await remoteDataSource.getAddresses();
      return right(addresses);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> editAddress({
    required AddressModel address,
  }) async {
    try {
      await remoteDataSource.editAddress(address: address);
      return right('Address updated');
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAddress({
    required String addressId,
  }) async {
    try {
      await remoteDataSource.deleteAddress(addressId: addressId);
      return right('Address deleted');
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
