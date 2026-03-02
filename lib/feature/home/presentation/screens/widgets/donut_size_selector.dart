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
        SizedBox(
          height: 44, // 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.productModel.sizes!.length,
            itemBuilder: (context, index) {
              final sizeInfoModel = widget.productModel.sizes![index];

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: BuildSizeOption(
                  size: sizeInfoModel.size,
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
        ),
      ],
    );
  }
}
