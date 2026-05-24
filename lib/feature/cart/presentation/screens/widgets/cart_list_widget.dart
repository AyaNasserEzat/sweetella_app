import 'package:flutter/material.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_item_widget.dart';

class CartListWidget extends StatelessWidget {
  final List<CartItemModel> cartItems;


  const CartListWidget({
    super.key,
    required this.cartItems,
  
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartItemWidget(item: cartItems[index]);
      },
    );
  }
}
