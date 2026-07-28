import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/cart/data/data_sources/address_remote_data_source.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/repositories/address_repo.dart';

class AddressRepoImp implements AddressRepo {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> addAddress({
    required AddressModel address,
  }) async {
    try {
      await remoteDataSource.addAddress(address: address);
      return right('Address saved successfully');
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
}
