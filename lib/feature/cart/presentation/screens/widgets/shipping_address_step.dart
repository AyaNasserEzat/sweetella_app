import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/core/widgets/custom_text_field.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';

class ShippingAddressStep extends StatefulWidget {
  final List<AddressModel> addresses;
  final AddressModel? selectedAddress;
  final ValueChanged<AddressModel> onAddressSelected;

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
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _floorNumberController = TextEditingController();
  final _buildingNumberController = TextEditingController();
  final _apartmentNumberController = TextEditingController();
  void _saveAddress() {
    final address = AddressModel(
      name: _nameController.text,
      phone: _phoneController.text,
      country: _countryController.text,
      city: _cityController.text,
      streetName: _streetNameController.text,
      floorNumber: _floorNumberController.text,
      buildingNumber: _buildingNumberController.text,
      apartmentNumber: _apartmentNumberController.text,
    );

    widget.onAddressSelected(address);

    Navigator.pop(context);

    _nameController.clear();
    _phoneController.clear();
    _countryController.clear();
    _cityController.clear();
    _streetNameController.clear();
    _floorNumberController.clear();
    _buildingNumberController.clear();
    _apartmentNumberController.clear();
  }

  void _addNewAddress() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  AppBarTitle(title: 'Shipping address'),

                  CustomTextField(
                    controller: _nameController,
                    hintTextColor: AppColors.greyLigt,
                    hintText: 'Full Name',
                  ),

                  CustomTextField(
                    controller: _phoneController,
                    hintTextColor: AppColors.greyLigt,
                    hintText: 'Phone Number',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _countryController,
                          hintTextColor: AppColors.greyLigt,
                          hintText: 'Country',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          controller: _cityController,
                          hintTextColor: AppColors.greyLigt,
                          hintText: 'City',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _streetNameController,
                          hintTextColor: AppColors.greyLigt,
                          hintText: 'Street Name',
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: _buildingNumberController,
                          hintTextColor: AppColors.greyLigt,
                          hintText: 'Building number',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _floorNumberController,
                          hintTextColor: AppColors.greyLigt,
                          hintText: 'Floor number',
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: _apartmentNumberController,
                          hintTextColor: AppColors.greyLigt,
                          hintText: 'Apartment number',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: _saveAddress,
                          text: 'Save address',
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarTitle(
          title: 'Shipping address',
          style: AppTextStyles.text24BoldPink,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: widget.addresses.length,
            itemBuilder: (context, index) {
              final address = widget.addresses[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: RadioListTile<AddressModel>(
                  title: Text(address.name),
                  subtitle: Text(
                    '${address.name}, ${address.streetName}\n${address.phone}',
                  ),
                  value: address,
                  groupValue: widget.selectedAddress,
                  onChanged: (value) => widget.onAddressSelected(value!),
                ),
              );
            },
          ),
        ),
        CustomButton(onPressed: _addNewAddress, text: 'Add New Address'),
      ],
    );
  }
}
