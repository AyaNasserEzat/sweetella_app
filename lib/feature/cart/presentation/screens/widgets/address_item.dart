import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddressCubit, AddressState, AddressModel?>(
      selector: (state) {
        return context.read<AddressCubit>().selectedAddress;
      },
      builder: (context, selectedAddress) {
        return GestureDetector(
          onTap: () {
            context.read<AddressCubit>().selectAddress(address);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            decoration: BoxDecoration(
              color: selectedAddress == address
                  ? AppColors.pinkLigt
                  : AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedAddress == address
                    ? AppColors.primaryColor
                    : Colors.grey,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address.name),
                        Text(address.phone),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primaryColor,
                            ),
                            Text(
                              '${address.streetName}, ${address.buildingNumber}, ${address.floorNumber}, ${address.apartmentNumber}, ${address.city}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Radio<AddressModel>(
                          side: WidgetStateBorderSide.resolveWith((states) {
                            return const BorderSide(
                              width: 1,
                              color: AppColors.primaryColor,
                            );
                          }),
                          activeColor: AppColors.primaryColor,
                          value: address,
                          groupValue: selectedAddress,
                          onChanged: (_) {
                            context.read<AddressCubit>().selectAddress(address);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                            color: AppColors.primaryColor,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                            color: AppColors.primaryColor,
                          ),
                        ],
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
}
