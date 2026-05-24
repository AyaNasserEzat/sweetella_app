import 'package:flutter/material.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_list_widget.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_summary_widget.dart';

class CartWideLayout extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final double totalPrice;
  final Function(int) onAdd;
  final Function(int) onRemove;
  final VoidCallback onCheckout;

  const CartWideLayout({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.onAdd,
    required this.onRemove,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        AppBarTitle(title: 'My Cart'),
        Expanded(
          child: Row(
            spacing: 20,
            children: [
              Expanded(
                flex: 2,
                child: CartListWidget(
                  cartItems: cartItems,
             
                ),
              ),
              Expanded(
                flex: 1,
                child: CartSummaryWidget(
                  totalPrice: totalPrice,
                  onCheckout: onCheckout,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}