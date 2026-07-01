import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/screens/widgets/favorite_button.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/product_details_screen.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/row_price_and_sale_price.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/sale_container.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  const ProductItem({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<FavoritesCubit>()),
                    BlocProvider.value(value: context.read<CartCubit>()),
                  ],
                  child: ProductDetailsScreen(productModel: productModel),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (productModel.salePrice != 0) SaleContainer(),
                      Spacer(),
                      FavoriteButton(productId: productModel.id),
                    ],
                  ),
                  Center(
                    child: productModel.imageUrl.isEmpty
                        ? Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: const Color(0xFFebebf4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: productModel.imageUrl,
                            placeholder: (context, url) => Container(
                              height: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFFebebf4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_not_supported),
                          ),
                  ),

                  SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      productModel.name,
                      style: AppTextStyles.text16BoldBlack,
                    ),
                  ),

                  productModel.attributes.isNotEmpty
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: productModel.attributes.map((attr) {
                              // Get the first option value as the default
                              final defaultOption = attr.options.isNotEmpty
                                  ? attr.options.first.value
                                  : '';

                              return Text(
                                '${attr.title}: $defaultOption',
                                style: AppTextStyles.text16Grey,
                              );
                            }).toList(),
                          ),
                        )
                      : const SizedBox.shrink(),

                  SizedBox(height: 5),
                  RowOfPriceAndSalePrice(productModel: productModel),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
