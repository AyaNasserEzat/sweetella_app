import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        onPressed: () {
          final selectionState = context.read<ProductAttributesCubit>().state;
          final cubit = context.read<ProductAttributesCubit>();

          // 2. Pass the map directly using selectionState.selectedAttributes
          context.read<CartCubit>().addToCart(
            CartItemModel(
              productId: productModel.id,
              productName: productModel.name,
              price: cubit.calculateFinalPrice(productModel).toInt(),
              imageUrl: productModel.imageUrl,
              quantity: 1,
              selectedAttributes:
                  selectionState.selectedAttributes, // <--- HERE IT IS!
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Add to Cart',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
