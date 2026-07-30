import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/add_address_bottom_sheet.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/address_item.dart';

class ShippingAddressStep extends StatelessWidget {
  final List<AddressModel> addresses;

  const ShippingAddressStep({super.key, required this.addresses});

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
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];

                return AddressItem(address: address);
              },
            ),
          ),
        ],
      ),
    );
  }
}
