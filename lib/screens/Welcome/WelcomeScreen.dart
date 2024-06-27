import 'package:flutter/material.dart';
import '../../theme/AppColors.dart';
import 'LoginSignupBtn.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.black2
          : Theme.of(context).cardColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 40.0, bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sehatyaab",
                  style: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Bridging the gap in medical facilities",
                  style: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300.0,
                  child: Image.asset('assets/images/logo-white.png'),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: LoginAndSignupBtn(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
