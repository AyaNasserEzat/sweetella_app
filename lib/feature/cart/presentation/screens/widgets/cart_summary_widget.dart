import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/widgets/custom_button.dart';

class CartSummaryWidget extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onCheckout;

  const CartSummaryWidget({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingValue = screenWidth * 0.04; // 4% of screen width
    final titleFontSize = screenWidth * 0.06; // 6% for Total
    final subTitleFontSize = screenWidth * 0.045; // 4.5% for Sub Total
    final priceFontSize = screenWidth * 0.05; // 5% for prices

    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0),
      child: Container(
        padding: EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 6,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Total",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        fontVariations: [const FontVariation('wght', 800)],
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: priceFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sub Total",
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontSize: subTitleFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        fontVariations: [const FontVariation('wght', 600)],
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const Text(
                    "\$33",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(onPressed: onCheckout, text: "Checkout"),
          ],
        ),
      ),
    );
  }
}