import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/build_attribute_option.dart';

class AttributeSelector extends StatefulWidget {
  const AttributeSelector({super.key, required this.attributeOption});
  final List<AttributeOption> attributeOption;

  @override
  State<AttributeSelector> createState() => _AttributeSelectorState();
}

class _AttributeSelectorState extends State<AttributeSelector> {
  int selectedSizeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.attributeOption.length,
        itemBuilder: (context, index) {
          final attributeOptionValue = widget.attributeOption[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BuildAttributeOption(
              size: attributeOptionValue.value,
              isSelected: selectedSizeIndex == index,
              onTap: () {
                setState(() {
                  selectedSizeIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
