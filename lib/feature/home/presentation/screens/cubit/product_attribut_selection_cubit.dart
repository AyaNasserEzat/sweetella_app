import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

class ProductAttributesCubit extends Cubit<Map<String, int>> {
  ProductAttributesCubit() : super({});

  void selectAttribute({
    required String attributeTitle,
    required int selectedIndex,
  }) {
    final updated = Map<String, int>.from(state);
    updated[attributeTitle] = selectedIndex;
    emit(updated);
  }

  int getSelectedIndex(String attributeTitle) {
    return state[attributeTitle] ?? 0;
  }

  Map<String, String> getSelectedAttributes(ProductModel product) {
    Map<String, String> result = {};

    for (var attribute in product.attributes) {
      final selectedIndex = state[attribute.title] ?? 0;

      result[attribute.title] = attribute.options[selectedIndex].value;
    }

    return result;
  }

  int calculateFinalPrice(ProductModel product) {
    int finalPrice = product.price;

    for (var attribute in product.attributes) {
      final selectedIndex = state[attribute.title] ?? 0;

      final option = attribute.options[selectedIndex];

      finalPrice += option.priceModifier.toInt();
    }

    return finalPrice;
  }
}
