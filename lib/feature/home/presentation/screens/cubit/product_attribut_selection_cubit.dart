import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_state.dart';

class ProductAttributesCubit extends Cubit<ProductSelectionState> {
  ProductAttributesCubit()
    : super(ProductSelectionState(selectedAttributes: {}));
  // Automatically select the first available option for every attribute group
  Map<String, String> initializeDefaults(ProductModel product) {
    final defaults = <String, String>{};
    for (var attr in product.attributes) {
      if (attr.options.isNotEmpty) {
        defaults[attr.title] = attr.options.first.value;
      }
    }
    emit(ProductSelectionState(selectedAttributes: defaults));
    return defaults;
  }

  // Triggers when a user selects a new item
  void selectAttribute(String attributeTitle, String optionValue) {
    final updatedSelections = Map<String, String>.from(
      state.selectedAttributes,
    );
    updatedSelections[attributeTitle] = optionValue;

    emit(ProductSelectionState(selectedAttributes: updatedSelections));
  }

  // Dynamic getter that calculates the real-time final price
  double calculateFinalPrice(ProductModel product) {
    double basePrice = product.salePrice > 0
        ? product.salePrice.toDouble()
        : product.price.toDouble();

    if (product.attributes.isEmpty) {
      return basePrice;
    }

    double total = 0;

    for (int i = 0; i < product.attributes.length; i++) {
      final attribute = product.attributes[i];

      String? selectedValue = state.selectedAttributes[attribute.title];

      final option = attribute.options.firstWhere(
        (opt) => opt.value == selectedValue,
        orElse: () => attribute.options.first,
      );

      total += option.priceModifier;
    }

    return total + basePrice;
  }
}
