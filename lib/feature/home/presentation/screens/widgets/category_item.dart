import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_state.dart';
class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.index,
    required this.categoryModel,
  });
  final int index;
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductCubit, ProductState, bool>(
      selector: (state) {
        return BlocProvider.of<ProductCubit>(context).selectedCategoryIndex ==
            index;
      },
      builder: (context, state) {
        print(
          'build category item with name: ${categoryModel.name} and selected: $state',
        );
        return Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
          decoration: BoxDecoration(
            color: state && categoryModel.imageUrl.isNotEmpty
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
                      color: state ? Colors.white : AppColors.primaryColor,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFebebf4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported_rounded,
                        //color: Colors.grey,
                      ),
                    )
                  : Container(width: 40),
              Text(
                categoryModel.name,
                style: state
                    ? AppTextStyles.text18SmiBoldwhite
                    : AppTextStyles.text18SmiyBoldDarkGray,
              ),
            ],
          ),
        );
      },
    );
  }
}