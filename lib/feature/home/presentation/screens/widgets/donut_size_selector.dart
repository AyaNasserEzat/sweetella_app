import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/build_size_option.dart';

class DonutSizeSelector extends StatefulWidget {
  const DonutSizeSelector({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<DonutSizeSelector> createState() => _DonutSizeSelectorState();
}

class _DonutSizeSelectorState extends State<DonutSizeSelector> {
  int selectedSizeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Size",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
            fontVariations: [FontVariation('wght', 900)],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: widget.productModel.sizes!
              .map(
                (sizeInfoModel) => BuildSizeOption(
                  size: sizeInfoModel.size,
                  onTap: () {
                    setState(() {
                      selectedSizeIndex = widget.productModel.sizes!.indexOf(
                        sizeInfoModel,
                      );
                    });
                  },
                  isSelected:
                      selectedSizeIndex ==
                      widget.productModel.sizes!.indexOf(sizeInfoModel),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
