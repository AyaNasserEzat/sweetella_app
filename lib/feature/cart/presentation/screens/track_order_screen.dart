import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarTitle(title: "Track Order"),
            const SizedBox(height: 20),
            Text('Order ID: $orderId', style: AppTextStyles.text18BoldDarkGray),
            const SizedBox(height: 20),
            // Order status timeline
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildStatusStep('Order Placed', '12:00 PM', true),
                  _buildConnector(true),
                  _buildStatusStep('Preparing', '12:15 PM', true),
                  _buildConnector(true),
                  _buildStatusStep('Out for Delivery', '1:00 PM', true),
                  _buildConnector(false),
                  _buildStatusStep('Delivered', 'Estimated 2:00 PM', false),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Delivery info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Information',
                    style: AppTextStyles.text18BoldDarkGray,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Delivery Address: 123 Main St, City, State',
                    style: AppTextStyles.text16Grey,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Estimated Delivery: 2:00 PM - 3:00 PM',
                    style: AppTextStyles.text16Grey,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Delivery Partner: John Doe',
                    style: AppTextStyles.text16Grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(String status, String time, bool isCompleted) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.primaryColor : AppColors.greyLigt,
          ),
          child: isCompleted
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : null,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(status, style: AppTextStyles.text16BoldBlack),
              Text(time, style: AppTextStyles.text16Grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(bool isCompleted) {
    return Container(
      width: 2,
      height: 40,
      color: isCompleted ? AppColors.primaryColor : AppColors.greyLigt,
      margin: const EdgeInsets.only(left: 9),
    );
  }
}
