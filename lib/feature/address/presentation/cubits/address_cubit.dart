import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/address/data/repositories/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepo addressRepo;
  List<AddressModel> _addresses = [];
  List<AddressModel> get addresses => _addresses;
  AddressCubit({required this.addressRepo}) : super(AddressInitial());

  AddressModel? selectedAddress;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final streetNameController = TextEditingController();
  final floorNumberController = TextEditingController();
  final buildingNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();

  AddressModel buildAddress({String? id}) {
    return AddressModel(
      id: id,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      country: countryController.text.trim(),
      city: cityController.text.trim(),
      streetName: streetNameController.text.trim(),
      floorNumber: floorNumberController.text.trim(),
      buildingNumber: buildingNumberController.text.trim(),
      apartmentNumber: apartmentNumberController.text.trim(),
    );
  }

  void populateControllers(AddressModel address) {
    nameController.text = address.name;
    phoneController.text = address.phone;
    countryController.text = address.country;
    cityController.text = address.city;
    streetNameController.text = address.streetName;
    floorNumberController.text = address.floorNumber;
    buildingNumberController.text = address.buildingNumber;
    apartmentNumberController.text = address.apartmentNumber;
  }

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    countryController.clear();
    cityController.clear();
    streetNameController.clear();
    floorNumberController.clear();
    buildingNumberController.clear();
    apartmentNumberController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    streetNameController.dispose();
    floorNumberController.dispose();
    buildingNumberController.dispose();
    apartmentNumberController.dispose();

    return super.close();
  }

  Future<void> loadAddresses() async {
    emit(AddressLoading());
    final result = await addressRepo.getAddresses();
    result.fold((failure) => emit(AddressError(message: failure.message)), (
      addresses,
    ) {
      _addresses = addresses;
      emit(AddressLoaded(addresses: List.from(_addresses)));
    });
  }

  Future<void> addAddress() async {
    final tempAddress = buildAddress(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
    );

    _addresses.insert(0, tempAddress);

    emit(AddressLoaded(addresses: List.from(_addresses)));

    final result = await addressRepo.addAddress(address: tempAddress);

    result.fold(
      (failure) {
        _addresses.removeWhere((item) => item.id == tempAddress.id);

        emit(AddressLoaded(addresses: List.from(_addresses)));

        emit(AddressError(message: failure.message));
      },
      (savedAddress) {
        final index = _addresses.indexWhere(
          (item) => item.id == tempAddress.id,
        );

        if (index != -1) {
          _addresses[index] = savedAddress;
        }
        clearControllers();
        emit(AddressLoaded(addresses: List.from(_addresses)));
      },
    );
  }

  Future<void> editAddress(AddressModel updatedAddress) async {
    final oldAddresses = List<AddressModel>.from(_addresses);

    // Update local list immediately
    final index = _addresses.indexWhere((item) => item.id == updatedAddress.id);

    if (index != -1) {
      _addresses[index] = updatedAddress;

      emit(AddressLoaded(addresses: List.from(_addresses)));
    }

    final result = await addressRepo.editAddress(address: updatedAddress);

    result.fold(
      (failure) {
        // Rollback if request failed
        _addresses = oldAddresses;

        emit(AddressLoaded(addresses: List.from(_addresses)));

        emit(AddressError(message: failure.message));
      },
      (_) {
        clearControllers();
      },
    );
  }

  Future<void> deleteAddress(String addressId) async {
    final oldAddresses = List<AddressModel>.from(_addresses);

    _addresses.removeWhere((address) => address.id == addressId);

    emit(AddressLoaded(addresses: List.from(_addresses)));

    final result = await addressRepo.deleteAddress(addressId: addressId);

    result.fold((failure) {
      _addresses = oldAddresses;

      emit(AddressLoaded(addresses: List.from(_addresses)));

      emit(AddressError(message: failure.message));
    }, (_) {});
  }

  void selectAddress(AddressModel address) {
    selectedAddress = address;
    emit(AddressSelectionChanged(selectedAddress: selectedAddress));
  }
}
