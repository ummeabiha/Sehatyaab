import 'package:flutter/material.dart';

class DoctorPanelHeader extends StatelessWidget {
  final String? text;
  final String imagePath;

  const DoctorPanelHeader({super.key, required this.imagePath, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(26.0),
      child: Column(
        children: [
          SizedBox(
            width: 250.0,
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 10.0),
          Text(
            text!,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
