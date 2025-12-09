import 'package:flutter/material.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/screens/checkout_screen.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_item_widget.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_summary_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      name: "Strandmond",
      price: 295.63,
      image: "assets/images/donuts_image.png",
      quantity: 2,
    ),
    CartItem(
      name: "Mollby",
      price: 749.62,
      image: "assets/images/donuts_image.png",
      quantity: 1,
    ),
    CartItem(
      name: "Micke",
      price: 155.21,
      image: "assets/images/donuts_image.png",
      quantity: 1,
      salePrice: 44,
    ),
  ];

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void _onCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CheckoutScreen(cartItems: cartItems, totalPrice: totalPrice),
      ),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartItemWidget(
          item: cartItems[index],
          onAdd: () {
            setState(() {
              cartItems[index].quantity++;
            });
          },
          onRemove: () {
            setState(() {
              if (cartItems[index].quantity > 1) {
                cartItems[index].quantity--;
              }
            });
          },
        );
      },
    );
  }

  Widget _buildWideLayout() {
    return Column(
      spacing: 10,
      children: [
        AppBarTitle(title: 'My Cart'),
        Expanded(
          child: Row(
            spacing: 20,
            children: [
              Expanded(flex: 2, child: _buildCartList()),
              Expanded(
                flex: 1,
                child: CartSummaryWidget(
                  totalPrice: totalPrice,
                  onCheckout: _onCheckout,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNormalLayout() {
    return Column(
      spacing: 10,
      children: [
        AppBarTitle(title: 'My Cart'),
        Expanded(child: _buildCartList()),
        CartSummaryWidget(totalPrice: totalPrice, onCheckout: _onCheckout),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: 30,
          bottom: 10,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > 600
                ? _buildWideLayout()
                : _buildNormalLayout();
          },
        ),
      ),
    );
  }
}
