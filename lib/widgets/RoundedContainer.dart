import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child; // Add the child parameter

  const RoundedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.black2
            : Theme.of(context).cardColor,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(30.0),
        //   topRight: Radius.circular(30.0),
        // ),
        //border: Border.all(color:Theme.of(context).shadowColor)
      ),
      child: child,
    );
  }
}
