// class ProductSelectionState {
//   // Holds the selections, e.g., {"Size": "M", "Flavor": "Chocolate"}
//   final Map<String, String> selectedAttributes;

//   ProductSelectionState({required this.selectedAttributes});
// }
// lib/features/customer_product/presentation/cubit/product_details_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

class ProductDetailsState {
  final ProductVariantModel? selectedVariant;
  final List<ProductAddonModel> selectedAddons;
  final double totalPrice;

  ProductDetailsState({
    required this.selectedVariant,
    required this.selectedAddons,
    required this.totalPrice,
  });

  ProductDetailsState copyWith({
    ProductVariantModel? selectedVariant,
    List<ProductAddonModel>? selectedAddons,
  }) {
    final variant = selectedVariant ?? this.selectedVariant;
    final addons = selectedAddons ?? this.selectedAddons;

    // حساب السعر الإجمالي تلقائياً (سعر الحجم + مجموع الإضافات المختارة)
    double basePrice = variant?.price ?? 0.0;
    double addonsPrice = addons.fold(0.0, (sum, addon) => sum + addon.price);

    return ProductDetailsState(
      selectedVariant: variant,
      selectedAddons: addons,
      totalPrice: basePrice + addonsPrice,
    );
  }
}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductModel product;

  ProductDetailsCubit(this.product)
    : super(
        ProductDetailsState(
          // اختيار أول حجم افتراضياً كأفضل ممارسة UX
          selectedVariant: product.hasVariants && product.variants.isNotEmpty
              ? product.variants.first
              : null,
          selectedAddons: [],
          totalPrice: product.hasVariants && product.variants.isNotEmpty
              ? product.variants.first.price
              : (product.price ?? 0.0),
        ),
      );

  void selectVariant(ProductVariantModel variant) {
    emit(state.copyWith(selectedVariant: variant));
  }

  void toggleAddon(ProductAddonModel addon) {
    List<ProductAddonModel> updatedAddons = List.from(state.selectedAddons);
    if (updatedAddons.contains(addon)) {
      updatedAddons.remove(addon);
    } else {
      updatedAddons.add(addon);
    }
    emit(state.copyWith(selectedAddons: updatedAddons));
  }
}
