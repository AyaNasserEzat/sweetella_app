import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';

class AddToCartBtn extends StatelessWidget {
  final CartItemModel product;

  const AddToCartBtn({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isInCart = BlocProvider.of<CartCubit>(
          context,
        ).isInCart(product.productId);

        return IconButton(
          icon: Icon(
            isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
            color: AppColors.primaryColor,
            size: 15,
          ),
          onPressed: () {
            BlocProvider.of<CartCubit>(context).addToCart(product);
          },
        );
      },
    );
  }
}
