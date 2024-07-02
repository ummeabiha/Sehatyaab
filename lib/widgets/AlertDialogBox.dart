import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Appointment Conflict',
          style: Theme.of(context).textTheme.bodyMedium),
      content: Text('You Already Have a Scheduled Appointment.',
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
