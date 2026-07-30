import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/repositories/address_repo.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';

class FakeAddressRepo implements AddressRepo {
  List<AddressModel> addresses = [];

  @override
  Future<Either<Failure, String>> addAddress({required AddressModel address}) async {
    addresses.add(address);
    return right('address added');
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    return right(addresses);
  }

  @override
  Future<Either<Failure, String>> editAddress({required AddressModel address}) async {
    final index = addresses.indexWhere((item) => item.id == address.id);
    if (index != -1) {
      addresses[index] = address;
    }
    return right('address updated');
  }

  @override
  Future<Either<Failure, String>> deleteAddress({required String addressId}) async {
    addresses.removeWhere((item) => item.id == addressId);
    return right('address deleted');
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

      cubit.nameController.text = 'John';
      cubit.phoneController.text = '01111111111';
      cubit.countryController.text = 'Egypt';
      cubit.cityController.text = 'Alexandria';
      cubit.streetNameController.text = 'Blue Street';
      cubit.floorNumberController.text = '1';
      cubit.buildingNumberController.text = '5';
      cubit.apartmentNumberController.text = '2';

      await cubit.addAddress();

      expect(cubit.state, isA<AddressLoaded>());
      final state = cubit.state as AddressLoaded;
      expect(state.addresses, hasLength(1));
      expect(state.selectedAddress, isNotNull);
    });

    test('edits an existing address and updates it in the repository', () async {
      final repo = FakeAddressRepo();
      const existingAddress = AddressModel(
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
      repo.addresses = [existingAddress];

      final cubit = AddressCubit(addressRepo: repo);
      await cubit.loadAddresses();

      cubit.nameController.text = 'Jane';
      cubit.phoneController.text = '01222222222';
      cubit.countryController.text = 'Egypt';
      cubit.cityController.text = 'Cairo';
      cubit.streetNameController.text = 'Main Street';
      cubit.floorNumberController.text = '3';
      cubit.buildingNumberController.text = '9';
      cubit.apartmentNumberController.text = '7';

      await cubit.editAddress(
        const AddressModel(
          id: 'a2',
          name: 'Jane',
          phone: '01222222222',
          country: 'Egypt',
          city: 'Cairo',
          streetName: 'Main Street',
          floorNumber: '3',
          buildingNumber: '9',
          apartmentNumber: '7',
        ),
      );

      expect(repo.addresses.single.name, 'Jane');
      expect((cubit.state as AddressLoaded).addresses.single.name, 'Jane');
    });

    test('deletes an address from the repository and local state', () async {
      final repo = FakeAddressRepo();
      repo.addresses = [
        const AddressModel(
          id: 'a3',
          name: 'Sara',
          phone: '01333333333',
          country: 'Egypt',
          city: 'Luxor',
          streetName: 'Palm Street',
          floorNumber: '4',
          buildingNumber: '11',
          apartmentNumber: '1',
        ),
      ];

      final cubit = AddressCubit(addressRepo: repo);
      await cubit.loadAddresses();

      await cubit.deleteAddress('a3');

      expect(repo.addresses, isEmpty);
      expect((cubit.state as AddressLoaded).addresses, isEmpty);
    });
  });
}
