// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sweetella/feature/home/data/models/product_model.dart';
// import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_state.dart';

// class ProductAttributesCubit extends Cubit<ProductSelectionState> {
//   ProductAttributesCubit()
//     : super(ProductSelectionState(selectedAttributes: {}));
//   // Automatically select the first available option for every attribute group
//   Map<String, String> initializeDefaults(ProductModel product) {
//     final defaults = <String, String>{};
//     for (var attr in product.attributes) {
//       if (attr.options.isNotEmpty) {
//         defaults[attr.title] = attr.options.first.value;
//       }
//     }
//     emit(ProductSelectionState(selectedAttributes: defaults));
//     return defaults;
//   }

//   // Triggers when a user selects a new item
//   void selectAttribute(String attributeTitle, String optionValue) {
//     final updatedSelections = Map<String, String>.from(
//       state.selectedAttributes,
//     );
//     updatedSelections[attributeTitle] = optionValue;

//     emit(ProductSelectionState(selectedAttributes: updatedSelections));
//   }

//   // Dynamic getter that calculates the real-time final price
//   double calculateFinalPrice(ProductModel product) {
//     double basePrice = product.salePrice > 0
//         ? product.salePrice.toDouble()
//         : product.price.toDouble();

//     if (product.attributes.isEmpty) {
//       return basePrice;
//     }

//     double total = 0;

//     for (int i = 0; i < product.attributes.length; i++) {
//       final attribute = product.attributes[i];

//       String? selectedValue = state.selectedAttributes[attribute.title];

//       final option = attribute.options.firstWhere(
//         (opt) => opt.value == selectedValue,
//         orElse: () => attribute.options.first,
//       );

//       total += option.priceModifier;
//     }

//     return total + basePrice;
//   }
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
