import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/add_address_bottom_sheet.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/address_bloc_builder.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          AddressBlocBuilder(),
        ],
      ),
    );
  }
}
