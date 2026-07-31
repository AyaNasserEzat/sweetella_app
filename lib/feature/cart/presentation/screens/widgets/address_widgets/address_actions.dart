import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/widgets/delete_confirmation_dialog.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/add_address_bottom_sheet.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/address_actions_button.dart';

class AddressActions extends StatelessWidget {
  const AddressActions({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddressActionButton(
          icon: Icons.edit,
          tooltip: 'Edit address',
          onPressed: () {
            addAddressBottomSheet(context, address: address);
          },
        ),

        AddressActionButton(
          icon: Icons.delete_outline,
          tooltip: 'Delete address',
          onPressed: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete address',
              message: 'Are you sure you want to delete this address?',
            );

            if (confirmed) {
              await context.read<AddressCubit>().deleteAddress(address.id!);
            }
          },
        ),
      ],
    );
  }
}
