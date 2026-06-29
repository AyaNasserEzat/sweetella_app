import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/attribute_bottomsheet.dart';

class AddToCartBtn extends StatefulWidget {
  final ProductModel productModel;

  const AddToCartBtn({super.key, required this.productModel});

  @override
  State<AddToCartBtn> createState() => _AddToCartBtnState();
}

class _AddToCartBtnState extends State<AddToCartBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textScaleAnimation;
  int _previousQuantity = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Elastic bounce effect for the cart icon
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.8,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.8,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
    ]).animate(_controller);

    // Fade/Scale effect for the quantity number popping up
    _textScaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // Watch the current quantity of this specific product in the cart
    final cartQuantity = context.select<CartCubit, int>((cubit) {
      final item = cubit.cartItems.firstWhere(
        (item) => item.productId == widget.productModel.id,
        orElse: () => CartItemModel(
          productId: '',
          productName: '',
          price: 0,
          imageUrl: '',
          quantity: 0,
          selectedAttributes: {},
        ),
      );
      return item.quantity;
    });

    // Trigger animation only if the item quantity increased
    if (cartQuantity > _previousQuantity) {
      _triggerAnimation();
    }
    _previousQuantity = cartQuantity;

    return GestureDetector(
      onTap: () {
        if (widget.productModel.attributes.isNotEmpty) {
          showAttributesBottomSheet(context, widget.productModel);
        } else {
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
      },
      child: Container(
        padding: const EdgeInsets.all(6),

        color:
            Colors.transparent, // Ensures the entire bounding box is clickable
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. The Shopping Cart Icon base
              Icon(
                cartQuantity > 0
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                color: AppColors.primaryColor,
                size: 35,
              ),
              // 2. Animated Number Inside the Cart
              if (cartQuantity > 0)
                Positioned(
                  top:
                      6, // Tweak this value depending on your specific font/icon size
                  child: ScaleTransition(
                    scale: _textScaleAnimation,
                    child: FadeTransition(
                      opacity: _textScaleAnimation,
                      child: Text(
                        '$cartQuantity',
                        style: const TextStyle(
                          color: Colors
                              .white, // Contrasts with the filled cart background
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
