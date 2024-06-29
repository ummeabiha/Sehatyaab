import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppTheme.dart';

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
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
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
              profile
                  ? const SizedBox(width: 45)
                  : IconButton(
                      icon: const Icon(
                        Icons.account_circle,
                        size: 32.0,
                      ),
                      onPressed: () {
                        // Add the desired action for the profile icon button
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
