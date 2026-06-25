import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';

class RowPlusOrMinus extends StatelessWidget {
  const RowPlusOrMinus({super.key, required this.cartItemModel});

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                if (cartItemModel.quantity <= 1) return;
                BlocProvider.of<CartCubit>(context).updateCartItemQuantity(
                  cartItemModel: cartItemModel,
                  quantity: cartItemModel.quantity - 1,
                );
              },
              icon: Icon(Icons.remove, color: Color(0xffe26784)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '${cartItemModel.quantity}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 12),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              BlocProvider.of<CartCubit>(context).updateCartItemQuantity(
                cartItemModel: cartItemModel,
                quantity: cartItemModel.quantity + 1,
              );
            },
            icon: Icon(Icons.add, color: Color(0xffe26784)),
          ),
        ),
      ],
    );
  }
}
