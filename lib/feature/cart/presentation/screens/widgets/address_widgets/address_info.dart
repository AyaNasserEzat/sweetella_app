import 'package:flutter/material.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),

        const SizedBox(height: 4),

        Text(address.phone),

        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined),

            const SizedBox(width: 6),

            Expanded(
              child: Text(
                '${address.streetName}, ${address.buildingNumber}, ${address.floorNumber}, ${address.apartmentNumber}, ${address.city}',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
