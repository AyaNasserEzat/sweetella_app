import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddressCubit, AddressState, AddressModel?>(
      selector: (state) {
        if (state is AddressLoaded) {
          return state.selectedAddress;
        }
        return null;
      },
      builder: (context, selectedAddress) {
        return RadioListTile<AddressModel>(
          value: address,
          groupValue: selectedAddress,
          onChanged: (_) {
            context.read<AddressCubit>().selectAddress(address);
          },
          title: Text(address.name),
        );
      },
    );
  }
}
