import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';
import 'add_address_bottom_sheet.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address});

  final AddressModel address;

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: AppColors.primaryColor.withValues(alpha: 0.1),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: AppColors.primaryColor, size: 18),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddressCubit, AddressState, AddressModel?>(
      selector: (state) {
        return context.read<AddressCubit>().selectedAddress;
      },
      builder: (context, selectedAddress) {
        final isSelected = selectedAddress == address;

        return GestureDetector(
          onTap: () {
            context.read<AddressCubit>().selectAddress(address);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.pinkLigt.withValues(alpha: 0.45)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
                width: isSelected ? 1.8 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              address.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address.phone,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${address.streetName}, ${address.buildingNumber}, ${address.floorNumber}, ${address.apartmentNumber}, ${address.city}',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Transform.scale(
                      scale: 1.4,
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
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildActionButton(
                          context: context,
                          icon: Icons.edit,
                          tooltip: 'Edit address',
                          onPressed: () {
                            addAddressBottomSheet(context, address: address);
                          },
                        ),
                        _buildActionButton(
                          context: context,
                          icon: Icons.delete_outline,
                          tooltip: 'Delete address',
                          onPressed: () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  title: const Text('Delete address'),
                                  content: const Text(
                                    'Are you sure you want to delete this address?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmed == true) {
                              await context.read<AddressCubit>().deleteAddress(
                                address.id ?? '',
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
