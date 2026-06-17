import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

class CustomCircleProgressIndcator extends StatelessWidget {
  const CustomCircleProgressIndcator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
  }
}
