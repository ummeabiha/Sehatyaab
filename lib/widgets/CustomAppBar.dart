import 'package:flutter/material.dart';
import 'package:sehatyaab/globals.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import 'package:sehatyaab/theme/AppTheme.dart';

import 'AlertDialogBox.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool profile;

  const CustomAppBar({
    super.key,
    this.profile = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      shadowColor: Theme.of(context).cardColor,
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 8.0,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Theme.of(context).brightness != Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  size: 32.0,
                ),
                onPressed: AppTheme.toggleTheme,
              ),
              const Text(
                'Sehatyaab',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (profile)
                IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 32.0,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialogBox(
                            title: 'Login Required',
                            content: 'Please Login to View Profiles.');
                      },
                    );
                  },
                ),
              if (!profile)
                IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 32.0,
                  ),
                  onPressed: () {
                    if (globalPatientId != null) {
                      Navigator.pushNamed(context, AppRoutes.patientProfile);
                    } else if (globalDoctorId != null) {
                      Navigator.pushNamed(
                          context, AppRoutes.displayDoctorProfile);
                    }
                    // } else {
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: Text('Login Required',
                    //             style: Theme.of(context).textTheme.bodyMedium),
                    //         content: Text('Please Login to View Profiles.',
                    //             style: Theme.of(context).textTheme.bodySmall),
                    //         actions: <Widget>[
                    //           OutlinedButton(
                    //             onPressed: () {
                    //               Navigator.of(context).pop();
                    //             },
                    //             child: const Text('OK'),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   );
                    // }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
