import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/white_card.dart';
import 'package:sweetella/feature/cart/presentation/screens/track_order_screen.dart';

class SuccessStep extends StatefulWidget {
  const SuccessStep({super.key});

  @override
  State<SuccessStep> createState() => _SuccessStepState();
}

class _SuccessStepState extends State<SuccessStep> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final String orderId = 'ORD${Random().nextInt(1000000).toString().padLeft(6, '0')}';

  @override
  void initState() {
    super.initState();
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
    return WhiteCard(
      child: Center(
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
            Text('Your order has been placed successfully.',textAlign: TextAlign.center, style: AppTextStyles.text16BoldBlack),
            const SizedBox(height: 16),
            Text('Order ID: $orderId', style: AppTextStyles.text18BoldDarkGray),
            const SizedBox(height: 32),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackOrderScreen(orderId: orderId),
                  ),
                );
              },
              text: 'Track Order',
            ),
          ],
        ),
      ),
    );
  }
}