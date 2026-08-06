import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';

class OrderSummaryStep extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final double totalPrice;
  final AddressModel? selectedAddress;
  final PaymentMethod? selectedPayment;

  const OrderSummaryStep({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.selectedAddress,
    required this.selectedPayment,
  });

  String _paymentMethodString(PaymentMethod? method) {
    switch (method) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.applePay:
        return 'Apple Pay';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
      default:
        return 'Not selected';
    }
  }

  @override
  Widget build(BuildContext context) {
    const double shipping = 5.0;
    const double tax = 2.0;
    const double discount = 1.0;
    final subtotal = totalPrice;
    final total = subtotal + shipping + tax - discount;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary', style: AppTextStyles.text24BoldPink),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'Products',
            child: Column(
              children: cartItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(item.imageUrl, width: 46, height: 46, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text('Qty: ${item.quantity}', style: TextStyle(color: AppColors.greyDark)),
                          ],
                        ),
                      ),
                      Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          _buildSectionCard(
            title: 'Shipping Address',
            child: selectedAddress != null
                ? Text(
                    '${selectedAddress!.name}\n${selectedAddress!.phone}\n${selectedAddress!.streetName}, ${selectedAddress!.buildingNumber}, ${selectedAddress!.floorNumber}, ${selectedAddress!.apartmentNumber}, ${selectedAddress!.city}',
                    style: TextStyle(color: AppColors.greyDark, height: 1.4),
                  )
                : const Text('No address selected'),
          ),
          const SizedBox(height: 12),
          _buildSectionCard(
            title: 'Payment Method',
            child: Text(_paymentMethodString(selectedPayment), style: TextStyle(color: AppColors.greyDark)),
          ),
          const SizedBox(height: 12),
          _buildSectionCard(
            title: 'Total Breakdown',
            child: Column(
              children: [
                _buildPriceRow('Subtotal', subtotal),
                _buildPriceRow('Shipping', shipping),
                _buildPriceRow('Tax', tax),
                _buildPriceRow('Discount', discount, isNegative: true),
                const Divider(height: 20),
                _buildPriceRow('Total', total, isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greySmallLigt),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.text18BoldDarkGray),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    double value, {
    bool isNegative = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold ? const TextStyle(fontWeight: FontWeight.w700) : null,
          ),
          Text(
            '${isNegative ? '-' : ''}\$${value.toStringAsFixed(2)}',
            style: isBold ? const TextStyle(fontWeight: FontWeight.w700) : null,
          ),
        ],
      ),
    );
  }
}

