import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/helper/extension.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/cart/presentation/screens/widgets/row_plus_or_minus.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;


  const CartItemWidget({
    super.key,
    required this.item,
  
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.w;
    final paddingValue = screenWidth * 0.03; // 3% of screen width
    final imageSize =
        screenWidth * 0.12; // 12% of screen width for smaller screens
    final spacing = screenWidth * 0.02; // 2% for spacing
    final nameFontSize = screenWidth * 0.04; // 4% for name
    final sizeFontSize = screenWidth * 0.035; // 3.5% for size

    return Container(
      padding: EdgeInsets.all(paddingValue),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          SizedBox(
            height: imageSize,
            width: imageSize,
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              placeholder: (context, url) => Container(
                height: imageSize,
                width: imageSize,

                decoration: BoxDecoration(
                  color: const Color(0xFFebebf4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.image_not_supported),
            ),
          ),
          //Image.asset(item.imageUrl, width: imageSize, height: imageSize, fit: BoxFit.contain),
          SizedBox(width: spacing),
          //  NAME & PRICE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.productName,
                    style: TextStyle(
                      fontSize: nameFontSize,
                      fontFamily: 'Nunito',
                      fontVariations: [const FontVariation('wght', 800)],
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Size: ${item.size}",
                    style: TextStyle(
                      fontSize: sizeFontSize,
                      color: Colors.grey,
                      fontFamily: 'Nunito',
                      fontVariations: [const FontVariation('wght', 600)],
                    ),
                  ),
                ),
                //(item: item),
              ],
            ),
          ),
          SizedBox(width: spacing),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // BlocBuilder<CartCubit, CartState>(
              //   builder: (context, state) {
              //     return 
                  IconButton(
                    onPressed: () {
                      context.read<CartCubit>().removeFromCart(item);
                     // context.read<CartCubit>().getCartItems();
                    },

                    icon: Icon(
                      CupertinoIcons.cart_badge_minus,
                      color: AppColors.primaryColor,
                    ),
                //   );
                // },
              ),
              SizedBox(height: screenWidth * 0.03),
              RowPlusOrMinus(),
            ],
          ),
        ],
      ),
    );
  }
}
