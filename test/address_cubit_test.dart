import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/repositories/address_repo.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';

class FakeAddressRepo implements AddressRepo {
  List<AddressModel> addresses = [];
  AddressModel? selectedAddress;

  @override
  Future<Either<Failure, String>> addAddress({required AddressModel address}) async {
    addresses.add(address);
    selectedAddress = address;
    return right('address added');
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    return right(addresses);
  }

  @override
  Future<Either<Failure, String>> selectAddress({required AddressModel address}) async {
    selectedAddress = address;
    return right('address selected');
  }
}

void main() {
  group('AddressCubit', () {
    test('loads saved addresses from the repository', () async {
      final repo = FakeAddressRepo();
      repo.addresses = [
        const AddressModel(
          id: 'a1',
          name: 'Jane',
          phone: '01000000000',
          country: 'Egypt',
          city: 'Cairo',
          streetName: 'Main Street',
          floorNumber: '2',
          buildingNumber: '12',
          apartmentNumber: '3',
        ),
      ];

      final cubit = AddressCubit(addressRepo: repo);
      await cubit.loadAddresses();

      expect(cubit.state, isA<AddressLoaded>());
      final state = cubit.state as AddressLoaded;
      expect(state.addresses, hasLength(1));
      expect(state.selectedAddress, isNull);
    });

    test('adds a new address and selects it', () async {
      final repo = FakeAddressRepo();
      final cubit = AddressCubit(addressRepo: repo);
      final address = const AddressModel(
        id: 'a2',
        name: 'John',
        phone: '01111111111',
        country: 'Egypt',
        city: 'Alexandria',
        streetName: 'Blue Street',
        floorNumber: '1',
        buildingNumber: '5',
        apartmentNumber: '2',
      );

      await cubit.addAddress(address);

      expect(cubit.state, isA<AddressLoaded>());
      final state = cubit.state as AddressLoaded;
      expect(state.addresses, contains(address));
      expect(state.selectedAddress, address);
    });
  });
}
