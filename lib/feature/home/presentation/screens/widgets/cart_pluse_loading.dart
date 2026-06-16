
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

class CartPulseLoading extends StatefulWidget {
  const CartPulseLoading({super.key});

  @override
  State<CartPulseLoading> createState() => _CartPulseLoadingState();
}

class _CartPulseLoadingState extends State<CartPulseLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return Icon(
              Icons.add_shopping_cart,
              size: 22 + (controller.value * 6), // 22 → 28 → 22
              color: AppColors.primaryColor,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}