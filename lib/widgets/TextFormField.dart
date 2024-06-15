import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final int? maxLines;
  final bool? enabled;
  final Color? fillColor;
  final bool? filled;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.labelText,
    required this.hintText,
    this.fillColor,
    this.maxLines,
    this.keyboardType,
    this.suffixIcon,
    this.enabled,
    this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: Theme.of(context).textTheme.bodySmall,
      enabled: enabled ?? true,
      decoration: InputDecoration(
        suffixIcon: Icon(
          suffixIcon,
          color: Theme.of(context).iconTheme.color,
        ),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        hintText: hintText,
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        focusedErrorBorder:
            Theme.of(context).inputDecorationTheme.focusedErrorBorder,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
    );
  }

  static copyWith({
    required TextEditingController controller,
    required String? Function(String? value)? validator,
    required String labelText,
    required String hintText,
    int? maxLines,
    String? keyboardType,
    IconData? suffixIcon,
    bool? enabled,
  }) {}
}
