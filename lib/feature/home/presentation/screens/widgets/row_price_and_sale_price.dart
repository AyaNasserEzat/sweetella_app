import 'package:flutter/cupertino.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
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
              spacing: 3,
              children: [
                if (productModel.salePrice != 0)
                  Text(
                    "${productModel.salePrice}\$",
                    style: AppTextStyles.priceTextGreen,
                  ),
                Text(
                  productModel.salePrice != 0
                      ? "${productModel.price}\$"
                      : "${productModel.price}\$",
                  style: productModel.salePrice != 0
                      ? AppTextStyles.text18GreyLineThrough
                      : AppTextStyles.text16BoldBlack,
                ),
              ],
            ),
          ),
        ),
        AddToCartBtn(productModel: productModel),

        // Icon(
        //   CupertinoIcons.cart_badge_plus,
        //   color: AppColors.primaryColor,
        //   fontWeight: FontWeight.bold,
        //   size: 22,
        // ),
      ],
    );
  }
}
