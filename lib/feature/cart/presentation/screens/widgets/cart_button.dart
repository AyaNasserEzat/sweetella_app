// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
// import 'package:sweetella/feature/cart/data/models/cart_model.dart';

// class CartButton extends StatelessWidget {
//   final CartItemModel item;
//   const CartButton({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<CartCubit, CartState, bool>(
//       selector: (state) {
//         if (state is CartLoaded) {
//           return state.cartItems.any((cartItem) => cartItem.productId == item.productId);
//         }
//         return false;
//       },
//       builder: (context, isInCart) {
//         return IconButton(
//           icon: Icon(
//             isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
//             color: isInCart ? Colors.green : Colors.grey,
//           ),
//           onPressed: () {
//             if (isInCart) {
//               context.read<CartCubit>().toogleAddOrRemove(item);
//             } else {
//               context.read<CartCubit>().addToCart(item);
//             }
//           },
//         );
//       },
//     );
//   }
// }
