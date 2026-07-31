import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/address/presentation/cubits/address_cubit.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/add_address_bottom_sheet.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/address_list_view.dart';

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
        debugPrint('AddressBlocBuilder state = ${state.runtimeType}');
        if (state is AddressLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AddressError) {
          return Center(child: Text(state.message));
        }

        if (state is AddressSelectionChanged || state is AddressLoaded) {
          if (context.read<AddressCubit>().addresses.isEmpty) {
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
                AddressListView(
                  addresses: context.read<AddressCubit>().addresses,
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
