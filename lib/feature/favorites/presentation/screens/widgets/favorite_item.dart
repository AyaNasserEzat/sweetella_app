import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/product_details_screen.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/row_price_and_sale_price.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/sale_container.dart';

class FavoriteItem extends StatelessWidget {
  final ProductModel productModel;

  const FavoriteItem({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(productModel: productModel),
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
                      IconButton(
                        onPressed: () {
                          context.read<FavoritesCubit>().removeFromFavorites(
                            productId: productModel.id,
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
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
                  SizedBox(height: 5),
                  RowOfPriceAndSalePrice(
                    productModel: productModel,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
