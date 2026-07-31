part of 'address_cubit.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;

  AddressLoaded({required this.addresses});
}

class AddressError extends AddressState {
  final String message;

  AddressError({required this.message});
}

class AddressSelectionChanged extends AddressState {
  final AddressModel? selectedAddress;

  AddressSelectionChanged({required this.selectedAddress});
}
