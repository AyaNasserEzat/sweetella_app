import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/address/presentation/cubits/address_cubit.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/address_actions.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/address_info.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/address_item_container.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/address_selection_radio.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddressCubit, AddressState, bool>(
      selector: (state) =>
          BlocProvider.of<AddressCubit>(context).selectedAddress?.id ==
          address.id,
      builder: (context, isSelected) {
        return AddressItemContainer(
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
        );
      },
    );
  }
}
