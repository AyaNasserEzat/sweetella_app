import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_cubit.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_state.dart';

class OrdersFilter extends StatelessWidget {
  const OrdersFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OrderCubit, OrderState, OrderStatus?>(
      selector: (state) {
        if (state is OrderLoaded) {
          return state.selectedStatus;
        }
        return null;
      },
      builder: (context, selectedStatus) {
        final filters = <OrderStatus?>[null, ...OrderStatus.values];
        print("build orderfilter $selectedStatus");
        return SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final status = filters[index];
              final bool isSelected = selectedStatus == status;
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    context.read<OrderCubit>().filterOrders(status);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      status == null ? 'All' : status.label,
                      style: selectedStatus == status
                          ? AppTextStyles.text18SmiBoldwhite
                          : AppTextStyles.text18SmiyBoldDarkGray,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
