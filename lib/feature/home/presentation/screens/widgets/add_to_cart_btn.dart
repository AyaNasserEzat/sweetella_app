import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/attribute_bottomsheet.dart';

class AddToCartBtn extends StatelessWidget {
  final ProductModel productModel;

  const AddToCartBtn({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    print('build add to cart button ${productModel.id}');

    final isInCart = context.select<CartCubit, bool>(
      (cubit) =>
          cubit.cartItems.any((item) => item.productId == productModel.id),
    );

    return IconButton(
      icon: Icon(
        isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
        color: AppColors.primaryColor,
      ),
      onPressed: () {
        if (productModel.attributes.isNotEmpty) {
          showAttributesBottomSheet(context, productModel);
        } else {
          final cubit = context.read<ProductAttributesCubit>();

          final selectedAttributes = cubit.getSelectedAttributes(productModel);

          final finalPrice = cubit.calculateFinalPrice(productModel);
          context.read<CartCubit>().addToCart(
            CartItemModel(
              productId: productModel.id,
              productName: productModel.name,
              price: finalPrice,
              quantity: 1,
              imageUrl: productModel.imageUrl,
              selectedAttributes: selectedAttributes,
            ),
          );
        }
      },
    );
  }
}
