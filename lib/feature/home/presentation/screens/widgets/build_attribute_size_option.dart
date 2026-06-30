import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildAttributeSizeOption extends StatelessWidget {
  final String optionValue;
  final bool isSelected;
  final String attributeTitle;

  const BuildAttributeSizeOption({
    super.key,
    required this.optionValue,
    this.isSelected = false,
    required this.attributeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          context.read<ProductAttributesCubit>().selectAttribute(
            attributeTitle,
            optionValue,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xffe26784) : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              width: 1.5,
            ),
          ),
          child: Text(
            optionValue,
            style: isSelected
                ? AppTextStyles.text16BoldWhite
                : AppTextStyles.text16Grey,
          ),
        ),
      ),
    );
  }
}
