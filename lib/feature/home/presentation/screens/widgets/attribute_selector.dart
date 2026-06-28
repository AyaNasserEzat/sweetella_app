import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/build_attribute_option.dart';

// class AttributeSelector extends StatefulWidget {
//   const AttributeSelector({
//     super.key,
//     required this.attributeOption,
//     required this.attributeTitle,
//   });
//   final List<AttributeOption> attributeOption;
//   final String attributeTitle;

//   @override
//   State<AttributeSelector> createState() => _AttributeSelectorState();
// }

// class _AttributeSelectorState extends State<AttributeSelector> {
//   int selectedSizeIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 44,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.attributeOption.length,
//         itemBuilder: (context, index) {
//           final attributeOptionValue = widget.attributeOption[index];
//           return Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: BuildAttributeOption(
//               size: attributeOptionValue.value,
//               isSelected: selectedSizeIndex == index,
//               onTap: () {
//                 setState(() {
//                   selectedSizeIndex = index;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

class AttributeSelector extends StatelessWidget {
  const AttributeSelector({
    super.key,
    required this.attributeTitle,
    required this.attributeOption,
  });

  final String attributeTitle;
  final List<AttributeOption> attributeOption;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAttributesCubit, Map<String, int>>(
      builder: (context, state) {
        final cubit = context.read<ProductAttributesCubit>();
        final selectedIndex = cubit.getSelectedIndex(attributeTitle);

        return SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: attributeOption.length,
            itemBuilder: (context, index) {
              final option = attributeOption[index];

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: BuildAttributeOption(
                  size: option.value,
                  isSelected: selectedIndex == index,
                  onTap: () {
                    cubit.selectAttribute(
                      attributeTitle: attributeTitle,
                      selectedIndex: index,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
