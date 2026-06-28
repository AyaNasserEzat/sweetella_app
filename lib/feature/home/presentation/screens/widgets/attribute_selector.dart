import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_state.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/build_attribute_option.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeSelector extends StatelessWidget {
  const AttributeSelector({
    super.key,
    required this.attributeOption,
    required this.attributeTitle,
  });

  final String attributeTitle;
  final List<AttributeOption> attributeOption;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: BlocBuilder<ProductAttributesCubit, ProductSelectionState>(
        builder: (context, state) {
          // Find out what value is currently selected for this attribute category
          final selectedValue = state.selectedAttributes[attributeTitle];

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: attributeOption.length,
            itemBuilder: (context, index) {
              final optionValue = attributeOption[index];

              // It is selected if its string value matches the cubit state value
              final isSelected = selectedValue == optionValue.value;

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: BuildAttributeOption(
                  size: optionValue.value,
                  isSelected: isSelected,
                  onTap: () {
                    // Update selection in your Cubit
                    context.read<ProductAttributesCubit>().selectAttribute(
                      attributeTitle,
                      optionValue.value,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
