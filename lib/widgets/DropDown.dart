import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final InputDecoration decoration;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.decoration,
    required this.items,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DropdownButtonFormField<T>(
      value: value,
      decoration: decoration.copyWith(
        filled: true,
        fillColor: Theme.of(context).brightness != Brightness.dark
            ? Theme.of(context).primaryColor
            : AppColors.gray2,
        labelStyle: theme.textTheme.bodySmall,
        hintStyle: theme.textTheme.bodySmall,
        border: theme.inputDecorationTheme.border,
        enabledBorder: theme.inputDecorationTheme.enabledBorder,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        errorBorder: theme.inputDecorationTheme.errorBorder,
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).iconTheme.color,
      ),
      style: theme.textTheme.bodySmall,
    );
  }
}
