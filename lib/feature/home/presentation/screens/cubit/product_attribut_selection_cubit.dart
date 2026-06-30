import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_state.dart';

class ProductAttributesCubit extends Cubit<ProductSelectionState> {
  ProductAttributesCubit()
    : super(ProductSelectionState(selectedAttributes: {}));
  final Map<String, String> defaultsAttribute = {};
  // Automatically select the first available option for every attribute group
  Map<String, String> initializeDefaults(ProductModel product) {
    for (var attr in product.attributes) {
      if (attr.options.isNotEmpty) {
        defaultsAttribute[attr.title] = attr.options.first.value;
      }
    }
    emit(ProductSelectionState(selectedAttributes: defaultsAttribute));
    return defaultsAttribute;
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
    // Base price defaults to salePrice if it exists, otherwise standard price
    double basePrice = product.salePrice > 0
        ? product.salePrice.toDouble()
        : product.price.toDouble();
    double totalModifier = 0.0;

    state.selectedAttributes.forEach((attributeTitle, selectedValue) {
      // Find the parent attribute category
      final attribute = product.attributes.firstWhere(
        (attr) => attr.title == attributeTitle,
        orElse: () => ProductAttribute(title: '', options: []),
      );

      // Find the specific chosen option modifier
      final option = attribute.options.firstWhere(
        (opt) => opt.value == selectedValue,
        orElse: () => AttributeOption(value: '', priceModifier: 0.0, stock: 0),
      );

      totalModifier += option.priceModifier;
    });

    return basePrice + totalModifier;
  }
}
