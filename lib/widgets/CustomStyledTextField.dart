import 'package:flutter/material.dart';

import '../theme/AppColors.dart';

class CustomStyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;

  const CustomStyledTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      shadowColor: Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).brightness != Brightness.dark
              ? AppColors.white
              : AppColors.gray2,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          prefixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
