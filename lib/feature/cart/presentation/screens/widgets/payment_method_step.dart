import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.selectedMethod;
  }

  void _onMethodChanged(PaymentMethod? value) {
    if (value == null) return;
    setState(() {
      _selectedMethod = value;
    });
    widget.onMethodSelected(value, null);
  }

  @override
  Widget build(BuildContext context) {
    final options = <_PaymentOption>[
      _PaymentOption(
        PaymentMethod.creditCard,
        'Credit Card',
        Icons.credit_card,
        isAvailable: false,
      ),
      _PaymentOption(
        PaymentMethod.paypal,
        'PayPal',
        Icons.account_balance_wallet,
        isAvailable: false,
      ),
      _PaymentOption(
        PaymentMethod.applePay,
        'Apple Pay',
        Icons.phone_iphone,
        isAvailable: false,
      ),
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
                secondary: option.isAvailable
                    ? null
                    : const Text('Coming soon'),
                onChanged: option.isAvailable ? _onMethodChanged : null,
                activeColor: AppColors.primaryColor,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PaymentOption {
  final PaymentMethod method;
  final String label;
  final IconData icon;
  final bool isAvailable;

  const _PaymentOption(
    this.method,
    this.label,
    this.icon, {
    this.isAvailable = true,
  });
}
