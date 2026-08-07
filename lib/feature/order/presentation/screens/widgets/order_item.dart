import 'package:flutter/material.dart';
import 'package:sweetella/core/extension/timestamp_extension.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/presentation/screens/track_order_screen.dart';
import 'package:sweetella/feature/order/presentation/screens/widgets/status_item.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrackOrderScreen(orderId: order.id ?? ''),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.greySmallLigt),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Order #${order.id}",
                    style: AppTextStyles.text16BoldBlack,
                  ),
                ),
                StatusItem(status: order.status),
              ],
            ),
            Text(
              order.createdAt.formattedDate,
              maxLines: 2,
              style: AppTextStyles.text14Grey,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Text(
              "Total: \$${order.total.toStringAsFixed(2)}",
              style: AppTextStyles.text16BoldBlack,
            ),
          ],
        ),
      ),
    );
  }
}
