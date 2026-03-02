import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? isPassword;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction=TextInputAction.next,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      obscureText:widget.isPassword == true ? isHidden : widget.obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: Icon(
                 isHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.primaryColor,
                ),
              )
            : null,
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: TextStyle(color: AppColors.primaryColor),
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.greyLigt, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.3),
        ),
      ),
    );
  }
}
