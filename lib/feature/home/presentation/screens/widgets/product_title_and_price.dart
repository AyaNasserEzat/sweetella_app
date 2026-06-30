import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_state.dart';

class ProductTitleAndPrice extends StatelessWidget {
  const ProductTitleAndPrice({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel.name, style: AppTextStyles.text24BoldPink),
        SizedBox(height: 8),
        BlocBuilder<ProductAttributesCubit, ProductSelectionState>(
          builder: (context, state) {
            return Text(
              'Price: ${BlocProvider.of<ProductAttributesCubit>(context).calculateFinalPrice(productModel)}\$',
              style: AppTextStyles.text18BoldDarkGray,
            );
          },
        ),
      ],
    );
  }
}
