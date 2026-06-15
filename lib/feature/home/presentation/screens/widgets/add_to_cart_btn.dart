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
    final isInCart = context.select<CartCubit, bool>(
      (cubit) =>
          cubit.cartItems.any((item) => item.productId == product.productId),
    );

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is AddToCartLoading || state is RemoveFromCartLoading) {
          return CircularProgressIndicator();
        }
        return IconButton(
          icon: Icon(
            isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            context.read<CartCubit>().toogleAddOrRemove(product);
          },
        );
      },
    );
  }
}
// class AddToCartBtn extends StatelessWidget {
//   final CartItemModel product;

//   const AddToCartBtn({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<CartCubit, CartState, bool>(
//       selector: (state) {
//         if (state is CartLoaded) {
//           return state.cartItems.any(
//             (item) => item.productId == product.productId,
//           );
//         }
//         return false;
//       },
//       builder: (context, isInCart) {
//         print('build icon button cart ${product.id}');
//         return IconButton(
//           icon: Icon(
//             isInCart
//                 ? Icons.shopping_cart
//                 : Icons.shopping_cart_outlined,
//             color: AppColors.primaryColor,
//             size: 15,
//           ),
//           onPressed: () {
//             context
//                 .read<CartCubit>()
//                 .toogleAddOrRemove(product);
//           },
//         );
//       },
//     );
//   }
// }
