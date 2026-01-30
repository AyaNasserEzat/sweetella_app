import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/add_to_cart_button.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_title_and_price.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/icon_favorite.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/plus_or_minus.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/reviews.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/product_description.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_size_selector.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffee3e3),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Image.network(productModel.imageUrl, height: 200),
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
                      DonutTitleAndPrice(productModel: productModel),
                      Reviews(),
                      ProductDescription(description: productModel.description),
                      const DonutSizeSelector(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            PlusOrMinus(),
                            Spacer(),
                            AddToCartButton(),
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
    );
  }
}
