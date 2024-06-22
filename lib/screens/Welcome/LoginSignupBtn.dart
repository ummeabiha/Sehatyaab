import 'package:flutter/material.dart';
import '../../widgets/ElevatedButton.dart';
import '../Login/LoginScreen.dart';
import '../Signup/SignUpScreen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ),
            );
          },
          label: "Login",
        ),
        const SizedBox(height: 20),
        CustomElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ),
            );
          },
          label: "Register",
        ),
      ],
    );
  }
}
