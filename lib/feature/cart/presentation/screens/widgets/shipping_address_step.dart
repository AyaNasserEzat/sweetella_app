import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/core/widgets/custom_text_field.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/white_card.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';

class ShippingAddressStep extends StatefulWidget {
  final List<Address> addresses;
  final Address? selectedAddress;
  final ValueChanged<Address> onAddressSelected;

  const ShippingAddressStep({
    super.key,
    required this.addresses,
    required this.selectedAddress,
    required this.onAddressSelected,
  });

  @override
  State<ShippingAddressStep> createState() => _ShippingAddressStepState();
}

class _ShippingAddressStepState extends State<ShippingAddressStep> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _zipController = TextEditingController();

  void _addNewAddress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) return 'Required';
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Invalid phone number';
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _zipController,
                decoration: const InputDecoration(labelText: 'Zip Code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Required';
                  if (!RegExp(r'^\d{5}$').hasMatch(value)) return 'Invalid zip code';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newAddress = Address(
                  name: _nameController.text,
                  phone: _phoneController.text,
                  address: _addressController.text,
                  zipCode: _zipController.text,
                );
                setState(() {
                  widget.addresses.add(newAddress);
                });
                _nameController.clear();
                _phoneController.clear();
                _addressController.clear();
                _zipController.clear();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Shipping Address', style: AppTextStyles.text24BoldPink),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.addresses.length,
              itemBuilder: (context, index) {
                final address = widget.addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: RadioListTile<Address>(
                    title: Text(address.name),
                    subtitle: Text('${address.address}, ${address.zipCode}\n${address.phone}'),
                    value: address,
                    groupValue: widget.selectedAddress,
                    onChanged: (value) => widget.onAddressSelected(value!),
                  ),
                );
              },
            ),
          ),
          CustomButton(
            onPressed: _addNewAddress,
            text: 'Add New Address',
          ),
        ],
      ),
    );
  }
}