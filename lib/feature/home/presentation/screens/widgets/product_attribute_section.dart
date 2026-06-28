import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_state.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/attribute_selector.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/build_attribute_option.dart';

// class ProductAttributesSection extends StatelessWidget {
//   final ProductModel productModel;

//   const ProductAttributesSection({super.key, required this.productModel});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: productModel.attributes.map((attribute) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 attribute.title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),

//               AttributeSelector(attributeOption: attribute.options, attributeTitle: attribute.title,),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

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
              Text(attribute.title),
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
