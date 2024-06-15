import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkTheme;
  final VoidCallback toggleTheme;

  const CustomAppBar({
    super.key,
    required this.isDarkTheme,
    required this.toggleTheme,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      foregroundColor: Theme.of(context).primaryColor,
      elevation: 4.0, // Add elevation to the app bar
      title: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Leading logo
            IconButton(
              icon: Icon(
                isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                size: 32.0, // Increase the icon size
              ),
              onPressed: toggleTheme,
            ),

            // Center title
            const Text(
              'Sehatyaab',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Trailing action button
            IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 32.0, // Increase the icon size
              ),
              onPressed: () {
                // Add the desired action for the profile icon button
              },
            ),
          ],
        ),
      ),
    );
  }
}
