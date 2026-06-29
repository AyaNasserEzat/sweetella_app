import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';

// class AddToCartButton extends StatelessWidget {
//   const AddToCartButton({super.key, required this.productModel});
//   final ProductModel productModel;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 180,
//       child: ElevatedButton(
//         onPressed: () {
//           final selectionState = context.read<ProductAttributesCubit>().state;
//           final cubit = context.read<ProductAttributesCubit>();

//           // 2. Pass the map directly using selectionState.selectedAttributes
//           context.read<CartCubit>().addToCart(
//             CartItemModel(
//               productId: productModel.id,
//               productName: productModel.name,
//               price: cubit.calculateFinalPrice(productModel).toInt(),
//               imageUrl: productModel.imageUrl,
//               quantity: 1,
//               selectedAttributes:
//                   selectionState.selectedAttributes, // <--- HERE IT IS!
//             ),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryColor,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//         ),
//         child: const Text(
//           'Add to Cart',
//           style: TextStyle(fontSize: 18, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
enum ButtonState { initial, animating, added }

class AddToCartButton extends StatefulWidget {
  final ProductModel productModel;

  const AddToCartButton({super.key, required this.productModel});

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton>
    with SingleTickerProviderStateMixin {
  ButtonState _currentState = ButtonState.initial;
  late AnimationController _animationController;

  // Internal Micro-interaction animations
  late Animation<double> _cartSlideIn;
  late Animation<double> _boxDrop;
  late Animation<double> _cartSlideOut;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // 1. Cart enters from the left and stops in the middle
    _cartSlideIn = Tween<double>(begin: -1.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    // 2. Box drops from the top into the cart
    _boxDrop = Tween<double>(begin: -2.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.35, 0.65, curve: Curves.bounceOut),
      ),
    );

    // 3. Cart drives off to the right
    _cartSlideOut = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   setState(() {
      //     _currentState = ButtonState.added;
      //   });

      // Reset the button back to initial look after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _currentState = ButtonState.initial;
            _animationController.reset();
          });
        }
      });
      //}
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAddToCart() {
    // Trigger visual micro-interaction
    setState(() {
      _currentState = ButtonState.animating;
    });
    _animationController.forward();

    // Trigger your existing Bloc logic safely
    final selectionState = context.read<ProductAttributesCubit>().state;
    final cubit = context.read<ProductAttributesCubit>();

    context.read<CartCubit>().addToCart(
      CartItemModel(
        productId: widget.productModel.id,
        productName: widget.productModel.name,
        price: cubit.calculateFinalPrice(widget.productModel).toInt(),
        imageUrl: widget.productModel.imageUrl,
        quantity: 1,
        selectedAttributes: selectionState.selectedAttributes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build add to cart button ${widget.productModel.id}');

    final isInCart = context.select<CartCubit, bool>(
      (cubit) => cubit.cartItems.any(
        (item) => item.productId == widget.productModel.id,
      ),
    );

    return GestureDetector(
      onTap: _currentState == ButtonState.initial ? _handleAddToCart : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _currentState == ButtonState.animating ? 140 : 160,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRect(
          child: Center(
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: _currentState == ButtonState.animating
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isInCart
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Add to cart',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              secondChild: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  double cartAlignmentX = _cartSlideOut.value > 0
                      ? _cartSlideOut.value
                      : _cartSlideIn.value;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment(cartAlignmentX, 0),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Stack(
                            children: [
                              // The dropping box/item structure
                              Align(
                                alignment: Alignment(0, _boxDrop.value - 0.2),
                                child: Opacity(
                                  opacity:
                                      (_animationController.value > 0.30 &&
                                          _animationController.value < 0.75)
                                      ? 1.0
                                      : 0.0,
                                  child: const Icon(
                                    Icons.inventory_2,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Cart structure
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
