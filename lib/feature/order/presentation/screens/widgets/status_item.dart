import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';

class StatusItem extends StatelessWidget {
  const StatusItem({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: _textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.primaryColor.withValues(alpha: 0.09);

      case OrderStatus.outForDelivery:
        return Colors.blue.shade100;

      case OrderStatus.delivered:
        return Colors.green.shade100;

      case OrderStatus.confirmed:
        return Colors.red.shade100;
      case OrderStatus.preparing:
        return Colors.yellow;
    }
  }

  Color get _textColor {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.primaryColor;

      case OrderStatus.confirmed:
        return Colors.blue;

      case OrderStatus.delivered:
        return Colors.green;

      case OrderStatus.outForDelivery:
        return Colors.red;
      case OrderStatus.preparing:
        return Colors.yellow;
    }
  }
}
