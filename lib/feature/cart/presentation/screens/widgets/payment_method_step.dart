import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
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
    final options = <_PaymentOption>[
      _PaymentOption(
        PaymentMethod.creditCard,
        'Credit Card',
        Icons.credit_card,
      ),
      _PaymentOption(
        PaymentMethod.paypal,
        'PayPal',
        Icons.account_balance_wallet,
      ),
      _PaymentOption(PaymentMethod.applePay, 'Apple Pay', Icons.phone_iphone),
      _PaymentOption(
        PaymentMethod.cashOnDelivery,
        'Cash on Delivery',
        Icons.local_shipping,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Payment Method', style: AppTextStyles.text24BoldPink),
          const SizedBox(height: 16),
          ...options.map((option) {
            final isSelected = _selectedMethod == option.method;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.08)
                    : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              child: RadioListTile<PaymentMethod>(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Row(
                  children: [
                    Icon(
                      option.icon,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.greyDark,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(option.label),
                  ],
                ),
                value: option.method,
                groupValue: _selectedMethod,
                onChanged: _onMethodChanged,
                activeColor: AppColors.primaryColor,
              ),
            );
          }),
          if (_selectedMethod == PaymentMethod.creditCard)
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!RegExp(r'^\d{16}$').hasMatch(value!))
                          return 'Invalid card number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expiryController,
                            decoration: const InputDecoration(
                              labelText: 'Expiry (MM/YY)',
                            ),
                            validator: (value) {
                              if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value!))
                                return 'Invalid expiry';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            decoration: const InputDecoration(labelText: 'CVV'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (!RegExp(r'^\d{3}$').hasMatch(value!))
                                return 'Invalid CVV';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PaymentOption {
  final PaymentMethod method;
  final String label;
  final IconData icon;

  const _PaymentOption(this.method, this.label, this.icon);
}
