import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/repositories/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepo addressRepo;
  final List<AddressModel> _addresses = [];
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

  AddressModel get address => AddressModel(
    name: nameController.text,
    phone: phoneController.text,
    country: countryController.text,
    city: cityController.text,
    streetName: streetNameController.text,
    floorNumber: floorNumberController.text,
    buildingNumber: buildingNumberController.text,
    apartmentNumber: apartmentNumberController.text,
  );

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
      _addresses.clear();
      _addresses.addAll(addresses);
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
    final result = await addressRepo.addAddress(address: address);
    result.fold((failure) => emit(AddressError(message: failure.message)), (_) {
      _addresses.add(address);
      _selectedAddress = address;
      emit(
        AddressLoaded(
          addresses: List.from(_addresses),
          selectedAddress: _selectedAddress,
        ),
      );
      clearControllers();
    });
  }

  Future<void> editAddress(AddressModel address) async {
    emit(AddressLoading());
    final result = await addressRepo.editAddress(address: address);
    result.fold((failure) => emit(AddressError(message: failure.message)), (_) {
      final index = _addresses.indexWhere((item) => item.name == address.name);
      if (index != -1) {
        _addresses[index] = address;
      }
      emit(
        AddressLoaded(
          addresses: List.from(_addresses),
          selectedAddress: _selectedAddress,
        ),
      );
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
