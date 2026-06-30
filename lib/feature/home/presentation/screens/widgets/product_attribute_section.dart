import 'package:flutter/widgets.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/attribute_selector.dart';

class ProductAttributesSection extends StatelessWidget {
  final ProductModel productModel;

  const ProductAttributesSection({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: productModel.attributes.map((attribute) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(attribute.title, style: AppTextStyles.text20BoldDarkGray),
              const SizedBox(height: 10),
              AttributeSelector(
                attributeTitle: attribute.title,
                attributeOption: attribute.options,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
