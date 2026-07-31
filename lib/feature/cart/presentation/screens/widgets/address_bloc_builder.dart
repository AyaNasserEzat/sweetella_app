import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/add_address_bottom_sheet.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/address_item.dart';

class AddressBlocBuilder extends StatelessWidget {
  const AddressBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      buildWhen: (previous, current) =>
          current is AddressLoading ||
          current is AddressLoaded ||
          current is AddressError,
      builder: (context, state) {
        if (state is AddressLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AddressError) {
          return Center(child: Text(state.message));
        }

        if (state is AddressLoaded) {
          if (state.addresses.isEmpty) {
            return const Center(child: Text('No addresses added yet'));
          }
          return Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Shipping address',
                  style: AppTextStyles.text18BoldDarkGray,
                ),
                const SizedBox(height: 5),
                CustomButton(
                  onPressed: () {
                    addAddressBottomSheet(context);
                  },
                  text: 'Add New Address',
                  icon: Icons.add,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.addresses.length,
                    itemBuilder: (context, index) {
                      final address = state.addresses[index];

                      return AddressItem(address: address);
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
