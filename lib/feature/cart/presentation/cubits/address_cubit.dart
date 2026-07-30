import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/repositories/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepo addressRepo;
  List<AddressModel> _addresses = [];
  AddressModel? _selectedAddress;

  AddressCubit({required this.addressRepo}) : super(AddressInitial());

  AddressModel? get selectedAddress => _selectedAddress;
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
      emit(
        AddressLoaded(
          addresses: List.from(_addresses),
          selectedAddress: _selectedAddress,
        ),
      );
    });
  }

  Future<void> addAddress() async {
    emit(AddressLoading());
    final addressToSave = buildAddress();
    final result = await addressRepo.addAddress(address: addressToSave);
    result.fold((failure) => emit(AddressError(message: failure.message)), (
      _,
    ) async {
      clearControllers();
      await loadAddresses();
    });
  }

  Future<void> editAddress(AddressModel address) async {
    emit(AddressLoading());
    final result = await addressRepo.editAddress(address: address);
    result.fold((failure) => emit(AddressError(message: failure.message)), (
      _,
    ) async {
      clearControllers();
      await loadAddresses();
    });
  }

  Future<void> deleteAddress(String addressId) async {
    if (addressId.isEmpty) return;

    emit(AddressLoading());
    final result = await addressRepo.deleteAddress(addressId: addressId);
    result.fold((failure) => emit(AddressError(message: failure.message)), (
      _,
    ) async {
      await loadAddresses();
    });
  }

  void selectAddress(AddressModel address) {
    _selectedAddress = address;
    emit(
      AddressLoaded(
        addresses: List.from(_addresses),
        selectedAddress: _selectedAddress,
      ),
    );
  }
}
