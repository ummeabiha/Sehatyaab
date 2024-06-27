import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: child,
    );
  }
}
