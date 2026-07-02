import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/helper/extension.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/snack_bar.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/quantity_cubit.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool isPressed = false;

  void addToCart() {
    final selectionState = context.read<ProductAttributesCubit>().state;
    final cubit = context.read<ProductAttributesCubit>();

    context.read<CartCubit>().addToCart(
      CartItemModel(
        productId: widget.productModel.id,
        productName: widget.productModel.name,
        price: cubit.calculateFinalPrice(widget.productModel).toInt(),
        imageUrl: widget.productModel.imageUrl,
        quantity: context.read<QuantityCubit>().state,
        selectedAttributes: selectionState.selectedAttributes,
      ),
    );

    context.read<QuantityCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() => isPressed = true);
        showsnakbar(
          context,
          "Added to cart successfully",
          SnachBarState.success,
        );
      },
      onPointerUp: (_) => setState(() => isPressed = false),
      child: AnimatedScale(
        scale: isPressed ? 0.6 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          width: context.w * .5,
          child: ElevatedButton(
            onPressed: addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
