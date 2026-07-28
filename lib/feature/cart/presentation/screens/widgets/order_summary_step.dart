import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
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
          const Text('Products:', style: AppTextStyles.text18BoldDarkGray),
          ...cartItems.map(
            (item) => ListTile(
              leading: Image.network(item.imageUrl, width: 50, height: 50),
              title: Text(item.productName),
              subtitle: Text('Quantity: ${item.quantity}'),
              trailing: Text(
                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
              ),
            ),
          ),
          const Divider(),
          const Text(
            'Shipping Address:',
            style: AppTextStyles.text18BoldDarkGray,
          ),
          if (selectedAddress != null)
            Text(
              '${selectedAddress!.name}\n${selectedAddress!.phone}, ${selectedAddress!.streetName}\n${selectedAddress!.floorNumber}',
            )
          else
            const Text('No address selected'),
          const Divider(),
          const Text(
            'Payment Method:',
            style: AppTextStyles.text18BoldDarkGray,
          ),
          Text(_paymentMethodString(selectedPayment)),
          const Divider(),
          const Text(
            'Total Breakdown:',
            style: AppTextStyles.text18BoldDarkGray,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal:'),
              Text('\$${subtotal.toStringAsFixed(2)}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Shipping:'),
              Text('\$${shipping.toStringAsFixed(2)}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Tax:'), Text('\$${tax.toStringAsFixed(2)}')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Discount:'),
              Text('-\$${discount.toStringAsFixed(2)}'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
