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

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.labelText,
    required this.hintText,
    this.maxLines,
    this.keyboardType,
    this.suffixIcon,
    this.enabled,
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
      ),
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
