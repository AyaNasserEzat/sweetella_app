import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/product_details_screen.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/add_to_cart_btn.dart';

class RowOfPriceAndSalePrice extends StatelessWidget {
  const RowOfPriceAndSalePrice({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              spacing: 5,
              children: [
                if (productModel.hasDiscount)
                  Text(
                    '${productModel.effectivePrice} EGP',
                    style: AppTextStyles.text16BoldBlack,
                  ),

                Text(
                  productModel.hasDiscount
                      ? '${productModel.price} EGP'
                      : productModel.formattedPrice,
                  style: productModel.hasDiscount
                      ? AppTextStyles.text18GreyLineThrough
                      : AppTextStyles.text16BoldBlack,
                ),
              ],
            ),
          ),
        ),
        productModel.variants.isEmpty
            ? BlocProvider(
                create: (context) => ProductDetailsCubit(productModel),
                child: AddToCartBtn(productModel: productModel),
              )
            : IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: context.read<FavoritesCubit>(),
                          ),
                          BlocProvider.value(value: context.read<CartCubit>()),
                        ],
                        child: ProductDetailsScreen(productModel: productModel),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.tune, color: AppColors.primaryColor, size: 35),
              ),
      ],
    );
  }
}
