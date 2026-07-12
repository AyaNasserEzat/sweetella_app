import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
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
      ],
      child: Scaffold(
        backgroundColor: const Color(0xfffee3e3), // لون الهيدر الخلفي (وردي)
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              PlusOrMinus(),
              const Spacer(),
              AddToCartButton(productModel: productModel),
            ],
          ),
        ),
        // استخدام Stack هنا هو الخدعة الذكية لحل مشكلة اللون الأبيض بدون تخريب قيود النص
        body: Stack(
          children: [
            // 1. خلفية بيضاء ثابتة تغطي النصف السفلي من الشاشة دائماً لضمان عدم ظهور لون وردي تحت
            Positioned(
              top:
                  MediaQuery.of(context).size.height *
                  0.4, // تبدأ تقريباً من تحت الصورة
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),

            // 2. السكرول الأساسي للصفحة
            CustomScrollView(
              slivers: [
                // هيدر الصورة
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70, bottom: 20),
                    child: SizedBox(
                      height: 220,
                      child: CachedNetworkImage(
                        imageUrl: productModel.imageUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFebebf4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported, size: 50),
                      ),
                    ),
                  ),
                ),

                // كارد محتوى المنتج الأبيض (باستخدام SliverToBoxAdapter ليعمل الـ readmore بكفاءة 100%)
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 15),
                            ProductTitleAndPrice(productModel: productModel),
                            const SizedBox(height: 10),
                            Reviews(),
                            const SizedBox(height: 20),
                            ProductDescription(
                              description: productModel.description,
                            ),
                            const SizedBox(height: 20),
                            if (productModel.attributes.isNotEmpty) ...[
                              ProductAttributesSection(
                                productModel: productModel,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ],
                        ),
                      ),
                      // زرار الفيفوريت
                      Positioned(
                        top: -25,
                        right: 30,
                        child: IconFavorite(productId: productModel.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
