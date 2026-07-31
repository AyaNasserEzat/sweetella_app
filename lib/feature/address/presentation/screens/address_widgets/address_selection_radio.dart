import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/address/presentation/cubits/address_cubit.dart';

class AddressSelectionRadio extends StatelessWidget {
  const AddressSelectionRadio({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.4,
      child: Radio<String>(
        side: WidgetStateBorderSide.resolveWith((states) {
          return const BorderSide(width: 1, color: AppColors.primaryColor);
        }),
        activeColor: AppColors.primaryColor,
        value: address.id!,
        groupValue: context.read<AddressCubit>().selectedAddress?.id,
        onChanged: (_) {
          context.read<AddressCubit>().selectAddress(address);
        },
      ),
    );
  }
}
