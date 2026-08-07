import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/custom_circle_progress_indecator.dart';
import 'package:sweetella/core/widgets/empty_widget.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/cart/presentation/screens/checkout_screen.dart';
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
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: 30,
            bottom: 50,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                AppBarTitle(title: "My Cart"),
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    buildWhen: (previous, current) =>
                        current is CartLoading ||
                        current is CartLoaded ||
                        current is CartError,
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return CustomCircleProgressIndcator();
                      } else if (state is CartLoaded) {
                        final cartItems = state.cartItems;
                        if (cartItems.isEmpty) {
                          return const EmptyWidget(
                            imageUrl: 'assets/images/empty_cart.png',
                          );
                        }
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
                                    // key: ValueKey(item.id),
                                  );
                                },
                              ),
                            ),
                            CartSummaryWidget(
                              totalPrice: totalPrice,
                              onCheckout: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: context.read<CartCubit>(),
                                      child: CheckoutScreen(
                                        cartItems: cartItems,
                                        totalPrice: totalPrice,
                                      ),
                                    ),
                                  ),
                                );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
