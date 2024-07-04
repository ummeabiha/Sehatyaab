import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  final String? title;
  final String? content;

  const AlertDialogBox({super.key, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(title!,
          style: Theme.of(context).textTheme.bodyMedium),
      content: Text(content!,
          style: Theme.of(context).textTheme.bodySmall),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
