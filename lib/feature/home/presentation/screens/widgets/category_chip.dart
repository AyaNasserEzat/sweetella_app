
import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

Widget categoryChip(String title, bool selected) {
  return Container(
    margin: const EdgeInsets.only(right: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: selected ? AppColors.primaryColor : AppColors.grey,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      spacing: 10,
      children: [
        Image.asset('assets/images/cake_category.png',color:selected? Colors.white:Colors.pink),
        Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
