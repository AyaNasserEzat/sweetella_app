import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/quantity_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/add_to_cart_button.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/product_title_and_price.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/icon_favorite.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/plus_or_minus.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/product_attribute_section.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/reviews.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/product_description.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProductAttributesCubit()..initializeDefaults(productModel),
        ),
        BlocProvider(create: (_) => QuantityCubit()),
        BlocProvider(create: (context) => sl<CartCubit>()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xfffee3e3),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: SizedBox(
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: productModel.imageUrl,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFebebf4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),

                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        ProductTitleAndPrice(productModel: productModel),
                        Reviews(),
                        ProductDescription(
                          description: productModel.description,
                        ),
                        productModel.attributes.isEmpty
                            ? Container()
                            : ProductAttributesSection(
                                productModel: productModel,
                              ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              PlusOrMinus(),
                              Spacer(),
                              AddToCartButton(productModel: productModel),
                              // AddToCartButton(productModel: productModel),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            IconFavorite(),
          ],
        ),
      ),
    );
  }
}
