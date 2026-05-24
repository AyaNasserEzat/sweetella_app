import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_item_widget.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/cart_summary_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04;
    return BlocProvider(
      create: (context) => sl<CartCubit>()..getCartItems(),
      child: Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        body: Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: 30,
            bottom: 10,
          ),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CartLoaded) {
                final cartItems = state.cartItems;
                final totalPrice = cartItems.fold<double>(
                  0,
                  (sum, item) => sum + item.price * item.quantity,
                );
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return CartItemWidget(
                            item: item,
                            onAdd: () {
                              context.read<CartCubit>().updateCartItemQuantity(
                                item.productId,
                                item.quantity + 1,
                              );
                            },
                            onRemove: () {
                              if (item.quantity > 1) {
                                context.read<CartCubit>().removeFromCart(
                                  item,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    CartSummaryWidget(
                      totalPrice: totalPrice,
                      onCheckout: () {
                        // Your checkout logic
                      },
                    ),
                  ],
                );
              } else if (state is CartError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
