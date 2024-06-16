import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child; // Add the child parameter

  const RoundedContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).scaffoldBackgroundColor: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        border: Border.all(color: Theme.of(context).cardColor),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black,
            blurRadius: 20.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
