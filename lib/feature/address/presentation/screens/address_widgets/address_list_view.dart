import 'package:flutter/material.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/address/presentation/screens/address_widgets/address_item.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({super.key, required this.addresses});
  final List<AddressModel> addresses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];

          return AddressItem(address: address);
        },
      ),
    );
  }
}
