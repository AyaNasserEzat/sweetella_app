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
      buildWhen: (previous, current) {
        // نتحقق من معرف المنتج في الحالة السابقة والحالية
        final prevId = previous is AddToCartLoading ? previous.productId : (previous is RemoveFromCartLoading ? previous.productId : null);
        final currId = current is AddToCartLoading ? current.productId : (current is RemoveFromCartLoading ? current.productId : null);
        
        // يعيد البناء فقط إذا تغيرت قائمة السلة، أو إذا كان التحميل يخص هذا المنتج
        return   
               prevId == product.productId || 
               currId == product.productId;
      },
      builder: (context, state) {
        
        if ((state is AddToCartLoading &&
                state.productId == product.productId) ||
            (state is RemoveFromCartLoading &&
                state.productId == product.productId)) {
          return CircularProgressIndicator();
        }
        else if(state is AddToCartError){
          return Text('error');
        }
        else {
          print('build icon button cart ');
          return IconButton(
            icon: Icon(
              isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              context.read<CartCubit>().toogleAddOrRemove(product);
            },
          );
        }
      },
    );
  }
}

// class AddToCartBtn extends StatelessWidget {
//   final CartItemModel product;

//   const AddToCartBtn({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<CartCubit, CartState, bool>(
//       selector: (state) {
//         return context.read<CartCubit>().cartItems.any(
//           (item) => item.productId == product.productId,
//         );
//       },
      

//       builder: (context, state) {
        
//         print('build icon button cart ');
//         if ((state is AddToCartLoading &&
//                 state.productId == product.productId) ||
//             (state is RemoveFromCartLoading &&
//                 state.productId == product.productId)) {
//           return const SizedBox(
//             width: 24,
//             height: 24,
//             child: CircularProgressIndicator(strokeWidth: 2),
//           );
//         }

//         return IconButton(
//           icon: Icon(
//             isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
//           ),
//           onPressed: () {
//             context.read<CartCubit>().toogleAddOrRemove(product);
//           },
//         );
//       },
//     );
//   }
// }
