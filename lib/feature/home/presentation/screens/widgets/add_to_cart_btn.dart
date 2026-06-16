import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/cart_pluse_loading.dart';

class AddToCartBtn extends StatelessWidget {
  final CartItemModel product;

  const AddToCartBtn({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print('build add to cart button ${product.productId}');
    final isInCart = context.select<CartCubit, bool>(
      (cubit) =>
          cubit.cartItems.any((item) => item.productId == product.productId),
    );
    final isloading = context.select<CartCubit, bool>(
      (cubit) =>
          (cubit.state is AddToCartLoading &&
              (cubit.state as AddToCartLoading).productId ==
                  product.productId) ||
          (cubit.state is RemoveFromCartLoading &&
              (cubit.state as RemoveFromCartLoading).productId ==
                  product.productId),
    );

  return isloading
    ? const CartPulseLoading()
    : IconButton(
        icon: Icon(
          isInCart
              ? Icons.shopping_cart
              : Icons.shopping_cart_outlined,
          color: AppColors.primaryColor,
        ),
        onPressed: () {
          context.read<CartCubit>().toogleAddOrRemove(product);
        },
      );
  }
}