import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/core/widgets/custom_text_field.dart';
import 'package:sweetella/core/widgets/snack_bar.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/address/presentation/cubits/address_cubit.dart';

Future<dynamic> addAddressBottomSheet(
  BuildContext screenContext, {
  AddressModel? address,
}) {
  final cubit = BlocProvider.of<AddressCubit>(screenContext);

  if (address != null) {
    cubit.populateControllers(address);
  }

  return showModalBottomSheet(
    context: screenContext,
    isScrollControlled: true,
    builder: (sheetContext) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Form(
            key: cubit.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                AppBarTitle(
                  title: address == null ? 'Shipping address' : 'Edit address',
                ),

                CustomTextField(
                  controller: cubit.nameController,
                  hintTextColor: AppColors.greyLigt,
                  hintText: 'Full Name',
                ),

                CustomTextField(
                  controller: cubit.phoneController,
                  hintTextColor: AppColors.greyLigt,
                  hintText: 'Phone Number',
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: cubit.countryController,
                        hintTextColor: AppColors.greyLigt,
                        hintText: 'Country',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        controller: cubit.cityController,
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
                        controller: cubit.streetNameController,
                        hintTextColor: AppColors.greyLigt,
                        hintText: 'Street Name',
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: cubit.buildingNumberController,
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
                        controller: cubit.floorNumberController,
                        hintTextColor: AppColors.greyLigt,
                        hintText: 'Floor number',
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: cubit.apartmentNumberController,
                        hintTextColor: AppColors.greyLigt,
                        hintText: 'Apartment number',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () async {
                          if (address == null) {
                            await cubit.addAddress();
                            showsnakbar(
                              sheetContext,
                              "Added  Addrees  Succesfully",
                              SnachBarState.success,
                            );
                          } else {
                            final updatedAddress = cubit.buildAddress(
                              id: address.id,
                            );
                            await cubit.editAddress(updatedAddress);
                            showsnakbar(
                              sheetContext,
                              "Edited Addrees  Succesfully",
                              SnachBarState.success,
                            );
                          }
                          if (Navigator.canPop(sheetContext)) {
                            Navigator.pop(sheetContext);
                          }
                        },
                        text: address == null ? 'Add address' : 'Save changes',
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
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
