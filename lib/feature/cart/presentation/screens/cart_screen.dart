import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_item_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),

      // ✅ CART LIST
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right : 16,top: 30,bottom: 10),
        child: Column(
          spacing: 10,
          children: [
            Text(
              "My Cart",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
                color: AppColors.greyDark,
                fontVariations: [FontVariation('wght', 900)],
              ),
            ),
            Expanded(
              child: ListView.builder(
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
              ),
            ),

            // ✅ TOTAL + CHECKOUT
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 6,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontVariations: [FontVariation('wght', 800)],
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          "Sub Total",
                          style: TextStyle(
                            color: AppColors.greyDark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${33}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CustomButton(onPressed: () {}, text: "Checkout"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
