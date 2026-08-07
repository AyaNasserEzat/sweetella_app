import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_cubit.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_state.dart';

class OrderFilterItem extends StatelessWidget {
  const OrderFilterItem({super.key, required this.status});

  final OrderStatus? status;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OrderCubit, OrderState, bool>(
      selector: (state) {
        if (state is! OrderLoaded) return false;
        return state.selectedStatus == status;
      },
      builder: (context, isSelected) {
        debugPrint('Rebuild ${status?.label ?? "All"} : $isSelected');

        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {
              context.read<OrderCubit>().filterOrders(status);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                status?.label ?? 'All',
                style: isSelected
                    ? AppTextStyles.text18SmiBoldwhite
                    : AppTextStyles.text18SmiyBoldDarkGray,
              ),
            ),
          ),
        );
      },
    );
  }
}
