import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.selected,
    required this.categoryModel,
  });
  final bool selected;
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
      decoration: BoxDecoration(
        color: selected && categoryModel.imageUrl.isNotEmpty
            ? AppColors.primaryColor
            : AppColors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        spacing: 10,
        children: [
          categoryModel.imageUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: categoryModel.imageUrl,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  color: selected ? Colors.white : AppColors.primaryColor,
                  placeholder: (context, url) =>
                      Container(decoration: BoxDecoration(color: Color(0xFFebebf4),borderRadius: BorderRadius.circular(20)),),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_not_supported_rounded,
                    //color: Colors.grey,
                  ),
                )
              : Container(width: 40),
          Text(
            categoryModel.name,
            style: selected
                ? AppTextStyles.text18SmiBoldwhite
                : AppTextStyles.text18SmiyBoldDarkGray,
          ),
        ],
      ),
    );
  }
}
