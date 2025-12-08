import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/white_card.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';

class PaymentMethodStep extends StatefulWidget {
  final PaymentMethod? selectedMethod;
  final Function(PaymentMethod, CardDetails?) onMethodSelected;

  const PaymentMethodStep({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  State<PaymentMethodStep> createState() => _PaymentMethodStepState();
}

class _PaymentMethodStepState extends State<PaymentMethodStep> {
  PaymentMethod? _selectedMethod;
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.selectedMethod;
  }

  void _onMethodChanged(PaymentMethod? value) {
    setState(() {
      _selectedMethod = value;
    });
    if (value == PaymentMethod.creditCard) {
      // If credit card, validate and pass details
      if (_formKey.currentState!.validate()) {
        final details = CardDetails(
          number: _cardNumberController.text,
          expiry: _expiryController.text,
          cvv: _cvvController.text,
        );
        widget.onMethodSelected(value!, details);
      }
    } else {
      widget.onMethodSelected(value!, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Method', style: AppTextStyles.text24BoldPink),
          const SizedBox(height: 16),
          RadioListTile<PaymentMethod>(
            title: const Text('Credit Card'),
            value: PaymentMethod.creditCard,
            groupValue: _selectedMethod,
            onChanged: _onMethodChanged,
          ),
          if (_selectedMethod == PaymentMethod.creditCard)
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: const InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (!RegExp(r'^\d{16}$').hasMatch(value!)) return 'Invalid card number';
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryController,
                          decoration: const InputDecoration(labelText: 'Expiry (MM/YY)'),
                          validator: (value) {
                            if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value!)) return 'Invalid expiry';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvController,
                          decoration: const InputDecoration(labelText: 'CVV'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (!RegExp(r'^\d{3}$').hasMatch(value!)) return 'Invalid CVV';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          RadioListTile<PaymentMethod>(
            title: const Text('PayPal'),
            value: PaymentMethod.paypal,
            groupValue: _selectedMethod,
            onChanged: _onMethodChanged,
          ),
          RadioListTile<PaymentMethod>(
            title: const Text('Apple Pay'),
            value: PaymentMethod.applePay,
            groupValue: _selectedMethod,
            onChanged: _onMethodChanged,
          ),
          RadioListTile<PaymentMethod>(
            title: const Text('Cash on Delivery'),
            value: PaymentMethod.cashOnDelivery,
            groupValue: _selectedMethod,
            onChanged: _onMethodChanged,
          ),
        ],
      ),
    );
  }
}