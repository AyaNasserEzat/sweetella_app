import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/donuts_details_screen.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/row_price_and_sale_price.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/sale_container.dart';

class DonutCard extends StatelessWidget {
  final ProductModel productModel;
  //final Color backgroundColor;
  const DonutCard({
    super.key,
    required this.productModel,
    //required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = constraints.maxHeight;
        final imageHeight =
            cardWidth * 0.5; // Scale image height with card width
        final paddingValue = cardWidth * 0.04; // 4% of card width for padding
        final spacing = cardHeight * 0.03; // 3% of card height for spacing

        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonutsDetailsScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  //color: backgroundColor.withAlpha(160),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(paddingValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (productModel.salePrice != 0) SaleContainer(),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.heart),
                          ),
                        ],
                      ),
                      Center(
                        child: productModel.imageUrl.isEmpty
                            ? Container(
                                height: imageHeight,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFebebf4),
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // مش دايرة
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: productModel.imageUrl,
                                height: imageHeight,
                                fit: BoxFit.contain,
                              ),
                      ),

                      SizedBox(height: spacing),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          productModel.name,
                          style: AppTextStyles.text16BoldBlack,
                        ),
                      ),
                      SizedBox(height: spacing * 0.5),
                      RowOfPriceAndSalePrice(
                        salePrice: productModel.salePrice,
                        price: productModel.price,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
