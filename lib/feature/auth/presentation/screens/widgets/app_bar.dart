import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_text_styles.dart';

class AppBarTitle extends StatelessWidget {
  AppBarTitle({super.key, required this.title, this.haveArrow = false});
  final String title;
  bool? haveArrow = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        haveArrow == true
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              )
            : Container(),
        Expanded(
          child: Center(
            child: Text(title, style: AppTextStyles.text24BoldDarkGray),
          ),
        ),
      ],
    );
  }
}
