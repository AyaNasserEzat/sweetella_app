import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildAttributsOption extends StatelessWidget {
  const BuildAttributsOption({
    super.key,
    required this.attributeTitle,
    required this.optionValue,
    required this.isSelected,
  });

  final String attributeTitle;
  final AttributeOption optionValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductAttributesCubit>().selectAttribute(
          attributeTitle,
          optionValue.value,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Text(
          optionValue.value,
          style: isSelected
              ? AppTextStyles.text16BoldWhite
              : AppTextStyles.text16Grey,
        ),
      ),
    );
  }
}
