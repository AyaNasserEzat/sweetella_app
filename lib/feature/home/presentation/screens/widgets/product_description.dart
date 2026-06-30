import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppTextStyles.text20BoldDarkGray),
        SizedBox(height: 8),
        Text(
          description,
          style: AppTextStyles.text16SmiyBoldblack54,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
