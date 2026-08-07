import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/core/widgets/custom_button.dart';
import 'package:sweetella/core/widgets/snack_bar.dart';
import 'package:sweetella/feature/address/presentation/screens/address_screen.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';
import 'package:sweetella/feature/address/presentation/cubits/address_cubit.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_cubit.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_state.dart';
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
  late final OrderCubit _orderCubit;
  late BuildContext _providerContext;

  void _nextPage() {
    if (_currentPage < 2) {
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

  @override
  void initState() {
    super.initState();
    _orderCubit = sl<OrderCubit>();
  }

  @override
  void dispose() {
    _orderCubit.close();
    _pageController.dispose();
    super.dispose();
  }

  void _onPaymentMethodSelected(PaymentMethod method, CardDetails? details) {
    _orderCubit.selectPaymentMethod(method);
  }

  Future<void> _confirmOrder() async {
    final addressCubit = _providerContext.read<AddressCubit>();
    final selectedAddress = addressCubit.selectedAddress;

    await _orderCubit.createOrder(
      selectedAddress: selectedAddress,
      cartItems: widget.cartItems,
      totalPrice: widget.totalPrice,
    );

    if (!mounted) return;

    if (_orderCubit.state is OrderSuccess) {
      await _providerContext.read<CartCubit>().clearCart();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SuccessStep(orderId: _orderCubit.orderId),
        ),
      );
    }

    if (_orderCubit.state is OrderFailure) {
      final message = (_orderCubit.state as OrderFailure).message;
      showsnakbar(_providerContext, message, SnachBarState.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AddressCubit>()..loadAddresses()),
        BlocProvider.value(value: _orderCubit),
      ],
      child: Builder(
        builder: (context) {
          _providerContext = context;
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
                          AddressScreen(),
                          PaymentMethodStep(
                            selectedMethod: _orderCubit.selectedPaymentMethod,
                            onMethodSelected: _onPaymentMethodSelected,
                          ),
                          OrderSummaryStep(
                            cartItems: widget.cartItems,
                            totalPrice: widget.totalPrice,
                            selectedAddress: BlocProvider.of<AddressCubit>(
                              context,
                            ).selectedAddress,
                            selectedPayment: _orderCubit.selectedPaymentMethod,
                          ),
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
                                ? BlocBuilder<OrderCubit, OrderState>(
                                    builder: (context, state) {
                                      final isLoading = state is OrderLoading;
                                      return CustomButton(
                                        onPressed: _confirmOrder,
                                        text: isLoading
                                            ? 'Processing...'
                                            : 'Confirm & Pay',
                                      );
                                    },
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
