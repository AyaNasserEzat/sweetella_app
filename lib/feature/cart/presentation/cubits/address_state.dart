part of 'address_cubit.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;
  final AddressModel? selectedAddress;

  AddressLoaded({required this.addresses, this.selectedAddress});
}

class AddressError extends AddressState {
  final String message;

  AddressError({required this.message});
}

class ChangeSelectedAddreesState extends AddressState {}
