import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/core/widgets/snack_bar.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/address_cubit.dart';
import 'widgets/shipping_address_step.dart';
import 'widgets/payment_method_step.dart';
import 'widgets/order_summary_step.dart';
import 'widgets/success_step.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItemModel> cartItems;
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
  PaymentMethod? _selectedPaymentMethod;
  bool _isLoading = false;

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

  void _onPaymentMethodSelected(PaymentMethod method, CardDetails? details) {
    setState(() {
      _selectedPaymentMethod = method;
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
    return BlocProvider(
      create: (context) => sl<AddressCubit>()..loadAddresses(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldColor,
            appBar: AppBar(
              title: const Text(
                'Checkout',
                style: AppTextStyles.text24BoldDarkGray,
              ),
              centerTitle: true,
              backgroundColor: AppColors.scaffoldColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Stack(
              children: [
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
                          BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, state) {
                              if (state is AddressLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is AddressError) {
                                return Center(child: Text(state.message));
                              }

                              if (state is AddressLoaded) {
                                return ShippingAddressStep(
                                  addresses: state.addresses,
                                );
                              }

                              return const Center(
                                child: Text('No addresses added yet'),
                              );
                            },
                          ),
                          PaymentMethodStep(
                            selectedMethod: _selectedPaymentMethod,
                            onMethodSelected: _onPaymentMethodSelected,
                          ),
                          OrderSummaryStep(
                            cartItems: widget.cartItems,
                            totalPrice: widget.totalPrice,
                            selectedAddress: BlocProvider.of<AddressCubit>(
                              context,
                            ).selectedAddress,
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
                                : CustomButton(
                                    onPressed: () {
                                      if (BlocProvider.of<AddressCubit>(
                                                context,
                                              ).selectedAddress ==
                                              null &&
                                          _currentPage == 0) {
                                        showsnakbar(
                                          context,
                                          'please select addrees',
                                          SnachBarState.error,
                                        );
                                      } else {
                                        _nextPage();
                                      }
                                    },
                                    text: 'Next',
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
