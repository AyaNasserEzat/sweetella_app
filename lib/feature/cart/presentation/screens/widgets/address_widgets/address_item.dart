import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/address_actions.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/address_info.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/address_item_container.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/address_selection_radio.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddressCubit, AddressState, bool>(
      selector: (_) =>
          context.read<AddressCubit>().selectedAddress?.id == address.id,
      builder: (context, isSelected) {
        return GestureDetector(
          onTap: () {
            context.read<AddressCubit>().selectAddress(address);
          },
          child: AddressItemContainer(
            isSelected: isSelected,
            child: Row(
              children: [
                Expanded(child: AddressInfo(address: address)),

                Column(
                  children: [
                    AddressSelectionRadio(address: address),

                    AddressActions(address: address),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
