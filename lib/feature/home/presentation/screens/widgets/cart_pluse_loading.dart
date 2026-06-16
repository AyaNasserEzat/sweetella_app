
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
      lowerBound: 1,
      upperBound: 1.2,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Transform.scale(
          scale: controller.value,
          child: Icon(
            Icons.add_shopping_cart
            ,
            color: AppColors.primaryColor,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
