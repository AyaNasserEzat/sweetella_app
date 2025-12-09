import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/bottom_image.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/primary_color_container.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';
import 'widgets/shipping_address_step.dart';
import 'widgets/payment_method_step.dart';
import 'widgets/order_summary_step.dart';
import 'widgets/success_step.dart';

class CheckoutScreen extends StatefulWidget {
  final List<dynamic> cartItems; // Assuming cart items are passed
  final double totalPrice;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Address? _selectedAddress;
  PaymentMethod? _selectedPaymentMethod;
  CardDetails? _cardDetails;
  bool _isLoading = false;

  final List<Address> _addresses = [
    Address(
      name: 'John Doe',
      phone: '1234567890',
      address: '123 Main St',
      zipCode: '12345',
    ),
    // Add more dummy addresses
  ];

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _onAddressSelected(Address address) {
    setState(() {
      _selectedAddress = address;
    });
  }

  void _onPaymentMethodSelected(PaymentMethod method, CardDetails? details) {
    setState(() {
      _selectedPaymentMethod = method;
      _cardDetails = details;
    });
  }

  void _confirmOrder() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _currentPage = 3; // Go to success
    });
    _pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Checkout',style: AppTextStyles.text32BoldWhite,),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios, color: AppColors.white,),  ),
      ),
      
      body: Stack(
        children: [
          const PrimaryColorContainer(),
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ShippingAddressStep(
                      addresses: _addresses,
                      selectedAddress: _selectedAddress,
                      onAddressSelected: _onAddressSelected,
                    ),
                    PaymentMethodStep(
                      selectedMethod: _selectedPaymentMethod,
                      onMethodSelected: _onPaymentMethodSelected,
                    ),
                    OrderSummaryStep(
                      cartItems: widget.cartItems,
                      totalPrice: widget.totalPrice,
                      selectedAddress: _selectedAddress,
                      selectedPayment: _selectedPaymentMethod,
                    ),
                    const SuccessStep(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: CustomButton(
                          onPressed: _previousPage,
                          text: 'Back',
                        ),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _currentPage == 2
                          ? CustomButton(
                              onPressed: _confirmOrder,
                              text: _isLoading
                                  ? 'Processing...'
                                  : 'Confirm & Pay',
                            )
                          : CustomButton(onPressed: _nextPage, text: 'Next'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
