import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool removeUpperBorders;
  final bool blueColor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.blueColor = false,
    this.removeUpperBorders = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: removeUpperBorders
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
          backgroundColor: !blueColor
              ? (Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).cardColor
                  : AppColors.pink)
              : (Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).cardColor
                  : AppColors.blue5),
          overlayColor: Theme.of(context).hoverColor,
          elevation: 2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
      ),
    );
  }
}
