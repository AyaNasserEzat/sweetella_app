import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/home/presentation/screens/bottom_nav_bar.dart';
import 'package:sweetella/feature/order/presentation/screens/track_order_screen.dart';

class SuccessStep extends StatefulWidget {
  final String? orderId;

  const SuccessStep({super.key, this.orderId});

  @override
  State<SuccessStep> createState() => _SuccessStepState();
}

class _SuccessStepState extends State<SuccessStep>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late final String orderId;

  @override
  void initState() {
    super.initState();
    orderId = widget.orderId ?? 'PENDING';
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ScaleTransition(
                scale: _animation,
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.primaryColor,
                  size: 100,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Success!', style: AppTextStyles.text24BoldPink),
              const SizedBox(height: 8),
              const Text(
                'Your order has been placed successfully.',
                textAlign: TextAlign.center,
                style: AppTextStyles.text16BoldBlack,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  orderId == 'PENDING'
                      ? 'Preparing your order...'
                      : 'Order ID: $orderId',
                  style: AppTextStyles.text18BoldDarkGray,
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                onPressed: () {
                  if (orderId != 'PENDING') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TrackOrderScreen(orderId: orderId),
                      ),
                    );
                  }
                },
                text: 'Track Order',
                backgroundColor: AppColors.white,
                textColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const MainScreen(initialIndex: 0),
                    ),
                    (route) => false,
                  );
                },
                text: 'Back to Home',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
