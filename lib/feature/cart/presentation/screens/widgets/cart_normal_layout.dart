import 'package:flutter/material.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_item_widget.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_summary_widget.dart';

class CartNormalLayout extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalPrice;
  final Function(int) onAdd;
  final Function(int) onRemove;
  final VoidCallback onCheckout;

  const CartNormalLayout({
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
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return CartItemWidget(
                item: cartItems[index],
                onAdd: () => onAdd(1),
                onRemove: () => onRemove(1),
              );
            },
          ),
        ),
        CartSummaryWidget(totalPrice: totalPrice, onCheckout: onCheckout),
      ],
    );
  }
}
