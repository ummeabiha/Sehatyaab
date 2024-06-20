import 'package:flutter/material.dart';
import '../theme/AppColors.dart';

class ListTileWithCheckbox extends StatelessWidget {
  final String title;
  final bool value;

  const ListTileWithCheckbox({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Theme.of(context).brightness != Brightness.dark
            ? Theme.of(context).cardColor
            : AppColors.gray2,
      ),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.white),
        ),
        trailing: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.white, // Color of the checkbox when unchecked
          ),
          child: Checkbox(
            checkColor: Colors.white, // Color of the checkmark
            activeColor: AppColors.pink, // Color when the checkbox is checked
            value: value,
            onChanged: null, // Disable manual change
          ),
        ),
      ),
    );
  }
}
